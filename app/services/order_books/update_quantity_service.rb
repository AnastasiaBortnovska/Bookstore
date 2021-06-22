# frozen_string_literal: true

class OrderBooks::UpdateQuantityService
  QUANTITY_ACTION = {
    increment: 'increment',
    decrement: 'decrement'
  }.freeze

  def initialize(params)
    @order_book = OrderBook.find(params[:id])
    @quantity_action = params[:quantity_action]
  end

  def call
    case @quantity_action
    when QUANTITY_ACTION[:increment] then @order_book.update(quantity: increment)
    when QUANTITY_ACTION[:decrement] then @order_book.update(quantity: decrement) if more_than_one?
    end
  end

  private

  def increment
    @order_book.quantity + 1
  end

  def decrement
    @order_book.quantity - 1
  end

  def more_than_one?
    @order_book.quantity > 1
  end
end
