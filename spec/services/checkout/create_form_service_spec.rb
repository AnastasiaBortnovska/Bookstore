# frozen_string_literal: true

RSpec.describe Checkout::CreateFormService do
  let(:subject) { described_class.new(order, step) }
  let(:order) { create(:order) }

  describe 'address step' do
    let(:step) { CheckoutController::STEPS[:address] }

    it { expect(subject.call).to be_kind_of(AddressForm) }
  end

  describe 'payment step' do
    let(:step) { CheckoutController::STEPS[:payment] }

    it { expect(subject.call).to be_kind_of(PaymentForm) }
  end
end
