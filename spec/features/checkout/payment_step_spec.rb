# frozen_string_literal: true

RSpec.describe Checkout::PaymentStep do
  let!(:order) { create(:order, :with_iteam, :with_billing_address, :with_shipping_address, :with_delivery) }

  let(:payment_step) { described_class.new }
  let(:user) { create(:user, orders: [order]) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
    payment_step.load
  end

  it { expect(payment_step).to be_all_there }

  context 'when fills credit card correctly' do
    let(:valid_credit_card) { attributes_for(:credit_card) }

    before { payment_step.fill_in(valid_credit_card) }

    it { expect(Checkout::ConfirmStep.new).to be_displayed }
  end
end
