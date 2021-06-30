# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  CREATION_DATE_FORMAT = '%B %d, %Y'.freeze
  delegate_all

  def subtotal_price
    order_books.decorate.sum(&:sub_total)
  end

  def discount_price
    coupon ? count_discount_price : 0
  end

  def total_price
    subtotal_price + delivery_price - discount_price
  end

  def delivery_price
    delivery&.price || 0
  end

  def creation_date
    updated_at.strftime(CREATION_DATE_FORMAT)
  end

  private

  def count_discount_price
    (subtotal_price / coupon.discount_percent).round
  end
end
