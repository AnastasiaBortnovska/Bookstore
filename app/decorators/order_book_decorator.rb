# frozen_string_literal: true

class OrderBookDecorator < Draper::Decorator
  delegate_all

  def sub_total
    book.price * quantity
  end
end
