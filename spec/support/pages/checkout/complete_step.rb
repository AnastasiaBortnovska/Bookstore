# frozen_string_literal: true

class Checkout::CompleteStep < SitePrism::Page
  set_url '/checkout/complete'

  element :thank_for_order, 'h3', text: I18n.t('checkout.complete.thank_for_order')
  element :order_information, 'p'
  element :iteam_information, 'td'
  element :button_back_to_store, "input[type='submit']"
end
