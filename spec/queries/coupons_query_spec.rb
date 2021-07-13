# frozen_string_literal: true

RSpec.describe CouponsQuery do
  let(:coupon_query) { described_class.new(order, **params) }
  let(:order) { create(:order) }
  let(:params) do
    { code: coupon.code }
  end

  context 'when coupon is active' do
    let(:coupon) { create(:coupon) }

    before { coupon_query.call }

    it do
      expect(order.coupon).to eq coupon
    end
  end

  context 'when coupon is inactive' do
    let(:coupon) { create(:coupon, active: false) }

    it { expect(coupon_query.call).to be_nil }
  end
end
