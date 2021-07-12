# frozen_string_literal: true

RSpec.describe 'Orders' do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when user login' do
      before do
        login_as(user, scope: :user)
        get user_orders_path(user)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(subject).to render_template(:index) }
    end

    context 'when user log out' do
      before do
        get user_orders_path(user)
      end

      it { expect(response).to have_http_status(:not_found) }
      it { expect(subject).to render_template('errors/404.html') }
    end
  end

  describe '#show' do
    context 'when order exists' do
      let(:order) do
        create(:order, :with_iteam, :with_billing_address, :with_shipping_address, :with_delivery, :with_credit_card)
      end

      before do
        login_as(user, scope: :user)
        get user_order_path(id: order.id, user_id: user.id)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(subject).to render_template(:show) }
    end

    context 'when order doesnt exist' do
      let(:order) do
        create(:order, :with_iteam, :with_billing_address, :with_shipping_address, :with_delivery, :with_credit_card)
      end

      before do
        login_as(user, scope: :user)
        get user_order_path(id: order.id.next, user_id: user.id)
      end

      it { expect(response).to have_http_status(:not_found) }
      it { expect(subject).to render_template('errors/404.html') }
    end
  end
end
