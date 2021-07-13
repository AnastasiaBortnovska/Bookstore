# frozen_string_literal: true

require_relative 'order_payment'

class OrderPage < SitePrism::Page
  set_url '/users{/user_id}/orders{/order_id}'

  element :sipping_address_title, 'h3', text: I18n.t('orders.show.shipping_address')
  element :billing_address_title, 'h3', text: I18n.t('orders.show.billing_address')

  section :address_section, OrderAddress, '#information_block'
  section :delivery_section, OrderDeliverySection, '#information_block'
  section :payment_section, OrderPayment, '#information_block'
end
