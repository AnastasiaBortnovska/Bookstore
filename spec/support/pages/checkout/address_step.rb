require_relative 'shipping_form'
require_relative 'billing_form'

class Checkout::AddressStep < SitePrism::Page
  set_url '/checkout/address'

  element :title_billing_address, 'h3', text: I18n.t('checkout.address.billing_address')
  element :title_shipping_address, 'h3', text: I18n.t('checkout.address.shipping_address')
  element :button_save_and_continue, 'input[type="submit"]'
  element :checkbox_use_billing, 'span', text: I18n.t('checkout.address.use_billing')

  section :shipping_address_section, Checkout::ShippingForm, '#shipping_address_form'
  section :billing_address_section, Checkout::BillingForm, '#billing_address_form'
end
