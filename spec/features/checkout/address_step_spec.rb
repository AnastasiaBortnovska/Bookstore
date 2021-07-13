# frozen_string_literal: true

RSpec.describe Checkout::AddressStep do
  let!(:order) { create(:order, :with_item) }

  let(:address_step) { described_class.new }
  let(:user) { create(:user, orders: [order]) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
    address_step.load
  end

  it { expect(address_step).to be_all_there }

  describe 'fills billing and shipping address' do
    let(:delivery_step) { Checkout::DeliveryStep.new }

    before do
      create_list(:delivery, 2)
      address_step.shipping_address_section.fill_in(shipping_date)
      address_step.billing_address_section.fill_in(billing_date)
      address_step.button_save_and_continue.click
    end

    context 'when valid date' do
      let(:billing_date) { attributes_for(:address) }
      let(:shipping_date) { attributes_for(:address) }

      it { expect(delivery_step).to be_displayed }
    end

    context 'when valid date only for billing address' do
      let(:billing_date) { attributes_for(:address) }
      let(:shipping_date) { attributes_for(:address, first_name: nil) }

      it { expect(delivery_step).not_to be_displayed }
      it { expect(address_step.shipping_address_section).to have_span_error }
    end

    context 'when valid date only for shipping address' do
      let(:shipping_date) { attributes_for(:address) }
      let(:billing_date) { attributes_for(:address, first_name: nil) }

      it { expect(delivery_step).not_to be_displayed }
      it { expect(address_step.billing_address_section).to have_span_error }
    end
  end

  describe 'used checkbox use_billing' do
    let(:delivery_step) { Checkout::DeliveryStep.new }
    let(:billing_date) { attributes_for(:address) }

    before do
      create_list(:delivery, 2)
      address_step.billing_address_section.fill_in(billing_date)
      address_step.checkbox_use_billing.click
    end

    it 'redirect to delivery step' do
      expect(address_step).not_to have_shipping_address_section
      address_step.button_save_and_continue.click
      expect(delivery_step).to be_displayed
    end
  end
end
