# frozen_string_literal: true

RSpec.describe Checkout::UpdateService do
  let(:subject) { described_class.new(order, params, nil) }
  let(:order) { create(:order, :with_user) }

  before { subject.call(step) }

  describe 'step delivery' do
    let(:step) { CheckoutController::STEPS[:delivery] }
    let(:delivery) { create(:delivery) }
    let(:params) do
      { order: { delivery_id: delivery.id } }
    end

    it { expect(order.delivery).to eq(delivery) }
  end

  describe 'step confirm' do
    let(:step) { CheckoutController::STEPS[:confirm] }
    let(:params) { nil }

    it { expect(order.completed?).to eq true }
  end
end
