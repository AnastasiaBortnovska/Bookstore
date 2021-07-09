# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let(:order) { create(:order).decorate }

  describe '#discount_price' do
    context 'when coupon exists' do
      let(:order) { create(:order, :with_iteam, :with_coupon).decorate }
      let(:discount_price) { order.subtotal_price / order.coupon.discount_percent }

      it { expect(order.discount_price).to eq(discount_price.round) }
    end

    context 'when coupon doesnt exists' do
      it { expect(order.discount_price).to eq(OrderDecorator::DEFAULT_VALUE) }
    end
  end

  describe '#total_price' do
    let(:total_price) { order.subtotal_price + order.delivery_price - order.discount_price }

    context 'when coupon exists' do
      let(:order) { create(:order, :with_iteam, :with_coupon).decorate }

      it { expect(order.total_price).to eq(total_price) }
    end

    context 'when order delivery exists' do
      let(:order) { create(:order, :with_iteam, :with_delivery).decorate }

      it { expect(order.total_price).to eq(total_price) }
    end
  end

  describe '#delivery_price' do
    context 'when order delivery exists' do
      let(:order) { create(:order, :with_delivery).decorate }

      it { expect(order.delivery_price).to eq(order.delivery.price) }
    end

    context 'when order delivery doesnt exists' do
      it { expect(order.delivery_price).to eq(OrderDecorator::DEFAULT_VALUE) }
    end
  end

  describe '#creation_date' do
    it { expect(order.creation_date).to eq(order.updated_at.strftime(OrderDecorator::CREATION_DATE_FORMAT)) }
  end

  describe '#select_status' do
    context 'when order status in_delivery' do
      let(:order) { create(:order, status: 'in_delivery').decorate }

      it { expect(order.select_status).to eq([Order.statuses.keys[3], Order.statuses.keys[4]]) }
    end

    context 'when order status doesnt in_delivery' do
      it { expect(order.select_status).to eq([Order.statuses.keys[2], Order.statuses.keys[4]]) }
    end
  end
end
