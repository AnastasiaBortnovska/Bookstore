# frozen_string_literal: true

class Checkout::ConfirmDelivery < SitePrism::Section
  element :delivery_title, 'h3', text: I18n.t('checkout.partials.confirm.delivery_information.shipments')
  element :delivery_information, 'p'
  element :edit_link, 'span#edit_delivery a', text: I18n.t('checkout.partials.confirm.delivery_information.edit')
end
