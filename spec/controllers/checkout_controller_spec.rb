RSpec.describe CheckoutController do
  let(:order) { create(:order, user: user) }
  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:current_order).and_return(order)
  end

  shared_examples 'render template' do
    it { expect(response).to render_template(step) }
  end

  describe '#show' do
    context 'when step authentication' do
      let(:step) { CheckoutController::STEPS[:authentication] }

      context 'when user sign in' do
        before do 
          sign_in(user)
          get :show, params: { id: step }
        end
        it { expect(response).to redirect_to(checkout_path(:address)) }
      end

      context 'when user doent sign in' do
        before do 
          get :show, params: { id: step }
        end
        
        include_examples 'render template'
      end
    end

    context 'when step address' do
      let(:step) { CheckoutController::STEPS[:address] }
      before do 
        sign_in(user)
        get :show, params: { id: step }
      end

      include_examples 'render template'
      it { expect(assigns(:form)).to be_kind_of(AddressForm)}
    end

    context 'when step delivery' do
      let(:step) { CheckoutController::STEPS[:delivery] }
      before do 
        sign_in(user)
        get :show, params: { id: step }
      end

      include_examples 'render template'
      it { expect(assigns(:deliveries)).to eq(Delivery.all)}
    end

    context 'when step credit_card' do
      let(:step) { CheckoutController::STEPS[:credit_card] }
      before do 
        sign_in(user)
        get :show, params: { id: step }
      end

      include_examples 'render template'
      it { expect(assigns(:form)).to be_kind_of(CreditCardForm)}
    end

    [CheckoutController::STEPS[:confirm], CheckoutController::STEPS[:complete]].each do |step|
      context "when step #{step}" do
      let(:step) { step }
        before do 
          sign_in(user)
          get :show, params: { id: step }
        end

        include_examples 'render template'
      end
    end
  end

  describe '#update' do
    before do 
      sign_in(user)
      put :update, params: params
    end
    context 'when step address' do
      let(:step) { CheckoutController::STEPS[:address] }
      let(:billing_attributes) {attributes_for(:address)}
        context 'when use billing' do
        let(:params) do
          {id: step, address: { billing_address: billing_attributes}}
        end

        it { expect(order.billing_address.first_name).to eq billing_attributes[:first_name] }
        it { expect(order.shipping_address.first_name).to eq billing_attributes[:first_name] }
        it { expect(response).to redirect_to(checkout_path(:delivery)) }
      end
      context 'when doesnt use billing' do
        let(:shipping_attributes) {attributes_for(:address)}
        let(:params) do
          {id: step, address: { billing_address: billing_attributes, shipping_address: shipping_attributes}}
        end

        it{ expect(order.billing_address.first_name).to eq billing_attributes[:first_name] }
        it{ expect(order.shipping_address.first_name).to eq shipping_attributes[:first_name] }
        it { expect(response).to redirect_to(checkout_path(:delivery)) }
      end
      context 'when params is invalid' do
        let(:billing_attributes) {attributes_for(:address, first_name: nil)}
        let(:params) do
          {id: step, address: { billing_address: billing_attributes}}
        end

        include_examples 'render template'
      end
    end
    context 'when step delivery' do
      let(:step) { CheckoutController::STEPS[:delivery] }
      let(:delivery) {create(:delivery)}
        context 'when success' do
          let(:params) do
            {id: step, order: order.attributes.merge(delivery_id: delivery.id)}
          end

          it{ expect(order.delivery).to eq delivery }
          it { expect(response).to redirect_to(checkout_path(:credit_card)) }
        end
        context 'when failure' do
          let(:params) do
            {id: step, order: order.attributes.merge(delivery_id: nil)}
          end

          it{ expect(order.delivery).to be_nil }
          include_examples 'render template'
        end
    end
    context 'when step credit_card' do
      let(:step) { CheckoutController::STEPS[:credit_card] }
        context 'when success' do
          let(:credit_card_attributes) {attributes_for(:credit_card)}

          let(:params) do
            {id: step, credit_card: { credit_card: credit_card_attributes }}
          end

          it { expect(order.credit_card.number).to eq credit_card_attributes[:number] }
          it { expect(response).to redirect_to(checkout_path(:confirm)) }
        end

        context 'when failure' do
          let(:credit_card_attributes) {attributes_for(:credit_card, cvv: nil)}

          let(:params) do
            {id: step, credit_card: { credit_card: credit_card_attributes }}
          end

          it { expect(order.credit_card).to be_nil }
          include_examples 'render template'
        end
    end
    context 'when step confirm' do
      let(:step) { CheckoutController::STEPS[:confirm] }
      let(:params) do
        {id: step}
      end

      it { expect(order.completed?).to eq true }
      it { expect(response).to redirect_to(checkout_path(:complete)) }
    end
  end
end
