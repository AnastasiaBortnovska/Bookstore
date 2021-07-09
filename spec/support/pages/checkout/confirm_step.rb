# frozen_string_literal: true

require_relative 'confirm_address'
require_relative 'confirm_delivery'
require_relative 'confirm_payment'

class Checkout::ConfirmStep < SitePrism::Page
  set_url '/checkout/confirm'

  element :shipping_address_title, 'h3', text: I18n.t('checkout.confirm.shipping_address')
  element :billing_address_title, 'h3', text: I18n.t('checkout.confirm.billing_address')
  element :payment_title, 'h3', text: I18n.t('checkout.partials.confirm.payment_information.title')
  element :button_place_order, "input[type='submit']"
  element :iteam_information, 'td'

  section :address_section, Checkout::ConfirmAddress, '#information_block'
  section :delivery_section, Checkout::ConfirmDelivery, '#information_block'
  section :payment_section, Checkout::ConfirmPayment, '#information_block'
end
