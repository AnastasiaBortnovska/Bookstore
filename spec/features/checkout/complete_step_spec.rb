# frozen_string_literal: true

RSpec.describe Checkout::CompleteStep do
  let!(:order) { create(:order, :with_shipping_address, :with_item) }

  let(:complete_step) { described_class.new }
  let(:user) { create(:user, orders: [order]) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
    complete_step.load
  end

  it { expect(complete_step).to have_thank_for_order }
  it { expect(complete_step).to have_order_information(text: order.number) }
  it { expect(complete_step).to have_order_information(text: order.decorate.creation_date) }

  it {
    expect(complete_step).to have_order_information(text: I18n.t('checkout.complete.sent_email', email: user.email))
  }

  describe 'item block' do
    it { expect(complete_step).to have_item_information(text: order.order_books.first.book.title) }

    it {
      expect(complete_step).to have_item_information(text: order.order_books.first.book.decorate.short_description)
    }

    it { expect(complete_step).to have_item_information(text: "€#{order.order_books.first.book.price}") }
    it { expect(complete_step).to have_item_information(text: order.order_books.first.quantity) }
    it { expect(complete_step).to have_item_information(text: order.order_books.first.decorate.sub_total) }
  end
end
