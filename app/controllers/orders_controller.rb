# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authorize_resource

  ORDERS_PER_PAGE = 2

  include Pagy::Backend

  decorates_assigned :order

  def index
    @pagy, @orders = pagy(OrdersQuery.new(current_user, params).call, items: ORDERS_PER_PAGE)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def authorize_resource
    render 'errors/404.html', layout: false, status: :not_found unless current_user
  end
end
