# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  CREATION_DATE_FORMAT = '%B %d, %Y'
  DEFAULT_VALUE = 0
  delegate_all

  def subtotal_price
    order_books.decorate.sum(&:sub_total)
  end

  def discount_price
    coupon ? count_discount_price : DEFAULT_VALUE
  end

  def total_price
    subtotal_price + delivery_price - discount_price
  end

  def delivery_price
    delivery&.price || DEFAULT_VALUE
  end

  def creation_date
    created_at.strftime(CREATION_DATE_FORMAT)
  end

  def select_status
    if order.in_delivery?
      [Order.statuses.keys[3],
       Order.statuses.keys[4]]
    else
      [Order.statuses.keys[2], Order.statuses.keys[4]]
    end
  end

  def status_title
    status.capitalize.tr('_', ' ')
  end

  private

  def count_discount_price
    (subtotal_price / coupon.discount_percent).round
  end
end
