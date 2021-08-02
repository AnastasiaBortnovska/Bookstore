# frozen_string_literal: true

RSpec.describe 'Checkout' do
  let(:order) { create(:order, :with_user) }

  before { allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order) }

  context 'when address step' do
    before { get checkout_path(id: CheckoutController::STEPS[:address]) }

    it 'creates billing/shipping address and redirects to the delivery step' do
      expect(response).to render_template(:address)

      put checkout_path(id: CheckoutController::STEPS[:address]),
          params: { address: { billing_address: attributes_for(:address) } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(checkout_path(id: CheckoutController::STEPS[:delivery]))
    end

    it 'doesnt create billing/shipping address' do
      expect(response).to render_template(:address)

      put checkout_path(id: CheckoutController::STEPS[:address]),
          params: { address: { billing_address: attributes_for(:address, first_name: nil) } }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:address)
    end
  end

  context 'when delivery step' do
    let(:delivery) { create(:delivery) }

    before do
      CheckoutController.new.instance_variable_set(:@deliveries, delivery)
      get checkout_path(id: CheckoutController::STEPS[:delivery])
    end

    it 'creates order delivery and redirects to the payment step' do
      expect(response).to render_template(:delivery)

      put checkout_path(id: CheckoutController::STEPS[:delivery]), params: { order: { delivery_id: delivery.id } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(checkout_path(id: CheckoutController::STEPS[:payment]))
    end
  end

  context 'when payment step' do
    before { get checkout_path(id: CheckoutController::STEPS[:payment]) }

    it 'creates credit card and redirects to the confirm step' do
      expect(response).to render_template(:payment)

      put checkout_path(id: CheckoutController::STEPS[:payment]),
          params: { payment: { credit_card: attributes_for(:credit_card) } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(checkout_path(id: CheckoutController::STEPS[:confirm]))
    end

    it 'doesnt create credit card' do
      expect(response).to render_template(:payment)

      put checkout_path(id: CheckoutController::STEPS[:payment]),
          params: { payment: { credit_card: attributes_for(:credit_card, number: nil) } }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:payment)
    end
  end

  context 'when confirm step' do
    let(:order) do
      create(:order, :with_user, :with_billing_address, :with_shipping_address, :with_credit_card, :with_delivery)
    end

    it 'renders confirm template and redirect to complete step' do
      get checkout_path(id: CheckoutController::STEPS[:confirm])
      expect(response).to render_template(:confirm)

      put checkout_path(id: CheckoutController::STEPS[:confirm])

      expect(response).to redirect_to(checkout_path(id: CheckoutController::STEPS[:complete]))
    end
  end

  context 'when complete step' do
    let(:order) { create(:order, :with_user, :with_billing_address, :with_shipping_address) }

    it 'renders complete template and deletes session[:order_id]' do
      get checkout_path(id: CheckoutController::STEPS[:complete])
      expect(response).to render_template(:complete)

      put checkout_path(id: CheckoutController::STEPS[:complete])
      expect(request.session[:order_id]).to be_nil
    end
  end
end
