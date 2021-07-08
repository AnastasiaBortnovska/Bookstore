# frozen_string_literal: true

class OrderBooks::BooksCountService
  def initialize(order)
    @order = order
  end

  def call
    result = @order.order_books.each_with_object({ sum: 0 }) do |order, hash|
      hash[:sum] += order.quantity
    end
    result[:sum]
  end
end
