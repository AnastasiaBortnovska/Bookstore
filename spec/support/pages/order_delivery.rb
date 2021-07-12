# frozen_string_literal: true

class OrderDelivery < SitePrism::Section
  element :delivery_title, 'h3', text: I18n.t('orders.partials.delivery_information.shipments')
  element :delivery_information, 'p'
end
