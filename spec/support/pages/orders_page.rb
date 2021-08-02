# frozen_string_literal: true

class OrdersPage < SitePrism::Page
  set_url '/users{/user_id}/orders'

  element :title_number, 'th', text: I18n.t('orders.index.table.order_number')
  element :title_completed_at, 'th', text: I18n.t('orders.index.table.completed_at')
  element :title_status, 'th', text: I18n.t('orders.index.table.status')
  element :title_total, 'th', text: I18n.t('orders.index.table.total')
  element :order_information, 'td'
end
