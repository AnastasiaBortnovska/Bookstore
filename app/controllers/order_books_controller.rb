# frozen_string_literal: true

class OrderBooksController < ApplicationController
  before_action :initialize_current_order_session, only: :create

  def index
    @current_cart = OrderBook.where(order: current_order)
  end

  def create
    flash[:danger] = I18n.t('message.error.order_book.add_book') unless OrderBooksQuery.new(current_order,
                                                                                            **order_book_params).call
    redirect_to request.referer || root_path
  end

  def update
    unless OrderBooks::UpdateQuantityService.new(params).call
      flash[:danger] = I18n.t('message.error.order_book.update_quantity')
    end
    redirect_to order_books_path
  end

  def destroy
    if OrderBook.find(params[:id]).destroy
      flash[:success] = I18n.t('message.success.order_book.delete')
    else
      flash[:danger] = I18n.t('message.error.order_book.delete')
    end

    redirect_to order_books_path
  end

  private

  def order_book_params
    params.require(:order_book).permit(:quantity, :book_id)
  end

  def initialize_current_order_session
    session[:order_id] = new_order unless current_order
  end

  def new_order
    return user_last_cart if current_user&.orders&.exists?(status: :in_progress)

    Order.create(number: Orders::GenerateOrderNumberService.new.call, user: current_user).id
  end

  def user_last_cart
    current_user.orders.where(status: :in_progress).last&.id
  end
end
