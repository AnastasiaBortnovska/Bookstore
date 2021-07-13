# frozen_string_literal: true

RSpec.describe OrdersPage do
  let!(:user) { create(:user) }
  let!(:order) do
    create(:order, :with_item, :with_billing_address, :with_shipping_address, :with_delivery, :with_credit_card,
           user: user)
  end

  let(:orders_page) { described_class.new }

  before do
    login_as(user, scope: :user)
    orders_page.load(user_id: user.id)
  end

  it { expect(orders_page).to be_all_there }
  it { expect(orders_page).to have_order_information(text: order.number) }
  it { expect(orders_page).to have_order_information(text: order.decorate.status_title) }
  it { expect(orders_page).to have_order_information(text: "€#{order.decorate.total_price}") }
  it { expect(orders_page).to have_order_information(text: I18n.l(order.updated_at, format: :order_completion_date)) }

  it do
    orders_page.order_information(text: order.number).click
    expect(OrderPage.new).to be_displayed
  end
end
