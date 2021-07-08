# frozen_string_literal: true

class OrderBooksQuery
  def initialize(order, **params)
    @order = order
    @params = params.symbolize_keys
    @order_book = @order.order_books.find_by(book_id: @params[:book_id])
  end

  def call
    @order_book ? update_quantity : create_order_book
  end

  private

  def update_quantity
    @order_book.update(quantity: count_quantity)
  end

  def create_order_book
    @order.order_books.create(@params)
  end

  def count_quantity
    @order_book.quantity + @params[:quantity].to_i
  end
end
