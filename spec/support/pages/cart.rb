# frozen_string_literal: true

require_relative 'order_item'
require_relative 'coupon_form'

class Cart < SitePrism::Page
  set_url '/order_books'

  element :heading, 'h1', text: I18n.t('order_books.index.heading')
  element :product, 'span', text: I18n.t('order_books.index.product')
  element :price, 'span', text: I18n.t('order_books.index.price')
  element :quantity, 'span', text: I18n.t('order_books.index.quantity')
  element :sub_total, 'span', text: I18n.t('order_books.index.sub_total')
  element :title_order_summary, 'p', text: I18n.t('order_books.index.order_summary')
  element :title_coupon, 'p', text: I18n.t('order_books.index.coupon')
  element :button_checkout, 'button', text: I18n.t('order_books.index.checkout')
  element :item_info, 'p'
  element :empty_cart, 'h1', text: I18n.t('order_books.index.empty_cart')

  element :flash_success, '.alert-success'
  element :flash_failure, '.alert-danger'

  section :order_item, OrderItem, 'table.table.table-hover'
  section :coupon_form, CouponForm, 'form.simple_form.coupon'

  expected_elements :heading, :product, :price, :quantity, :sub_total, :title_order_summary, :title_coupon,
                    :button_checkout, :item_info, :order_item, :coupon_form
end
