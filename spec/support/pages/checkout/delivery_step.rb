# frozen_string_literal: true

class Checkout::DeliveryStep < SitePrism::Page
  set_url '/checkout/delivery'

  element :table_head_method, 'th', text: I18n.t('checkout.delivery.method')
  element :table_head_days, 'th', text: I18n.t('checkout.delivery.days')
  element :table_head_price, 'th', text: I18n.t('checkout.delivery.price')
  element :delivery_name, 'span.radio-text'
  element :delivery_days, 'span'
  element :delivery_price, 'span'
  element :button_save_and_continue, "input[type='submit']"
end
