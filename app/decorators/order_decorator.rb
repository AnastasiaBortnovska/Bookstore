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
    I18n.l(updated_at, format: :creation_date)
  end

  def select_status
    if order.in_delivery?
      %i[delivered canceled]
    else
      %i[in_delivery canceled]
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
