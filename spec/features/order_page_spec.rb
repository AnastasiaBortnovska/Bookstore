# frozen_string_literal: true

RSpec.describe OrderPage do
  let!(:user) { create(:user) }
  let!(:order) do
    create(:order, :with_iteam, :with_billing_address, :with_shipping_address, :with_delivery, :with_credit_card,
           user: user)
  end

  let(:order_page) { described_class.new }

  before do
    login_as(user, scope: :user)
    order_page.load(user_id: user.id, order_id: order.id)
  end

  it { expect(order_page).to be_all_there }

  describe 'address block' do
    it {
      expect(order_page.address_section).to have_adress_information(text: order.billing_address.decorate.full_name)
    }

    it {
      expect(order_page.address_section).to have_adress_information(text: order.shipping_address.decorate.full_name)
    }

    it { expect(order_page.address_section).to have_adress_information(text: order.billing_address.address) }
    it { expect(order_page.address_section).to have_adress_information(text: order.shipping_address.address) }
    it { expect(order_page.address_section).to have_adress_information(text: order.shipping_address.city) }
    it { expect(order_page.address_section).to have_adress_information(text: order.billing_address.city) }
    it { expect(order_page.address_section).to have_adress_information(text: order.billing_address.country) }
    it { expect(order_page.address_section).to have_adress_information(text: order.shipping_address.country) }
    it { expect(order_page.address_section).to have_adress_information(text: order.shipping_address.phone) }
    it { expect(order_page.address_section).to have_adress_information(text: order.billing_address.phone) }
  end

  describe 'delivery block' do
    it { expect(order_page.delivery_section).to have_delivery_information(text: order.delivery.name) }
    it { expect(order_page.delivery_section).to have_delivery_information(text: "€#{order.delivery.price}") }
  end

  describe 'payment block' do
    it {
      expect(order_page.payment_section).to have_payment_information(text: order.credit_card.decorate.masked_number)
    }

    it { expect(order_page.payment_section).to have_payment_information(text: order.credit_card.expire_date) }
  end
end
