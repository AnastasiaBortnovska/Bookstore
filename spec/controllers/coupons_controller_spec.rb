# frozen_string_literal: true

RSpec.describe CouponsController do
  let(:order) { create(:order) }

  before { allow(controller).to receive(:current_order).and_return(order) }

  describe '#update' do
    let(:coupon) { create(:coupon) }

    before { put :update, params: coupon_params }

    context 'when success' do
      let(:coupon_params) do
        { coupon: { code: coupon.code }, id: coupon.id }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(subject).to set_flash[:success].to(I18n.t('message.success.coupon.used')) }
    end

    context 'when failure' do
      let(:coupon_params) do
        { coupon: { code: rand(5) }, id: coupon.id }
      end

      it { expect(subject).to set_flash[:danger].to(I18n.t('message.error.coupon.used')) }
    end
  end
end
