# frozen_string_literal: true

RSpec.describe Checkout::CheckStepCompletionService do
  let(:subject) { described_class.new(order, step) }
  let(:order) { create(:order) }

  describe 'step address' do
    let(:step) { CheckoutController::STEPS[:address] }

    context 'when sucsses' do
      let(:order) { create(:order, :with_billing_address, :with_shipping_address) }

      it { expect(subject.call).to eq true }
    end

    context 'when failure' do
      let(:order) { create(:order, :with_shipping_address) }

      it { expect(subject.call).to eq false }
    end
  end

  describe 'step delivery' do
    let(:step) { CheckoutController::STEPS[:delivery] }

    context 'when sucsses' do
      let(:order) { create(:order, :with_delivery) }

      it { expect(subject.call).not_to be_nil }
    end

    context 'when failure' do
      it { expect(subject.call).to be_nil }
    end
  end

  describe 'step credit_card' do
    let(:step) { CheckoutController::STEPS[:credit_card] }

    context 'when sucsses' do
      let(:order) { create(:order, :with_credit_card) }

      it { expect(subject.call).not_to be_nil }
    end

    context 'when failure' do
      it { expect(subject.call).to be_nil }
    end
  end

  describe 'step confirm' do
    let(:step) { CheckoutController::STEPS[:confirm] }

    context 'when sucsses' do
      before { order.complete }

      it { expect(subject.call).to eq true }
    end

    context 'when failure' do
      it { expect(subject.call).to eq false }
    end
  end
end
