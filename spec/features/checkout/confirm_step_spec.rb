# frozen_string_literal: true

RSpec.describe Checkout::ConfirmStep do
  let!(:order) do
    create(:order, :with_item, :with_billing_address, :with_shipping_address, :with_delivery, :with_credit_card)
  end

  let(:confirm_step) { described_class.new }
  let(:user) { create(:user, orders: [order]) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
    confirm_step.load
  end

  it { expect(confirm_step).to be_all_there }

  describe 'address block' do
    it {
      expect(confirm_step.address_section).to have_adress_information(text: order.billing_address.decorate.full_name)
    }

    it {
      expect(confirm_step.address_section).to have_adress_information(text: order.shipping_address.decorate.full_name)
    }

    it { expect(confirm_step.address_section).to have_adress_information(text: order.billing_address.address) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.shipping_address.address) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.shipping_address.city) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.billing_address.city) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.billing_address.country) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.shipping_address.country) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.shipping_address.phone) }
    it { expect(confirm_step.address_section).to have_adress_information(text: order.billing_address.phone) }
  end

  describe 'delivery block' do
    let(:delivery_price) { order.order_delivery.delivery.price }

    it { expect(confirm_step.delivery_section).to have_delivery_information(text: order.order_delivery.delivery.name) }
    it { expect(confirm_step.delivery_section).to have_delivery_information(text: "€#{delivery_price}") }

    it 'click delivery edit button' do
      confirm_step.delivery_section.edit_link.click
      expect(Checkout::DeliveryStep.new).to be_displayed
    end
  end

  describe 'item block' do
    it { expect(confirm_step).to have_item_information(text: order.order_books.first.book.title) }
    it { expect(confirm_step).to have_item_information(text: order.order_books.first.book.decorate.short_description) }
    it { expect(confirm_step).to have_item_information(text: "€#{order.order_books.first.book.price}") }
    it { expect(confirm_step).to have_item_information(text: order.order_books.first.quantity) }
    it { expect(confirm_step).to have_item_information(text: order.order_books.first.decorate.sub_total) }
  end

  describe 'payment block' do
    it {
      expect(confirm_step.payment_section).to have_payment_information(text: order.credit_card.decorate.masked_number)
    }

    it { expect(confirm_step.payment_section).to have_payment_information(text: order.credit_card.expire_date) }

    it 'click credit card edit button' do
      confirm_step.payment_section.edit_link.click
      expect(Checkout::PaymentStep.new).to be_displayed
    end
  end

  describe 'click button place_order' do
    it 'redirects to complete step' do
      confirm_step.button_place_order.click
      expect(Checkout::CompleteStep.new).to be_displayed
    end
  end
end
