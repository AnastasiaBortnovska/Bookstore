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
    when QUANTITY_ACTION[:increment] then @order_book.increment!(:quantity)
    when QUANTITY_ACTION[:decrement] then @order_book.decrement!(:quantity) if more_than_one?
    end
  end

  private

  def more_than_one?
    @order_book.quantity > 1
  end
end
