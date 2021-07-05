# frozen_string_literal: true

RSpec.describe Checkout::CreateFormService do
  let(:subject) { described_class.new(order, step) }
  let(:order) { create(:order) }

  describe 'address step' do
    let(:step) { CheckoutController::STEPS[:address] }

    it { expect(subject.call).to be_kind_of(AddressForm) }
  end

  describe 'credit_card step' do
    let(:step) { CheckoutController::STEPS[:credit_card] }

    it { expect(subject.call).to be_kind_of(CreditCardForm) }
  end
end
