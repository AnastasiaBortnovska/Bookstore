# frozen_string_literal: true

class OrdersQuery
  ORDER_FILTERING = {
    'created_at DESC' => I18n.t('orders.filter.all'),
    'completed' => I18n.t('orders.filter.completed'),
    'in_delivery' => I18n.t('orders.filter.in_delivery'),
    'delivered' => I18n.t('orders.filter.delivered'),
    'canceled' => I18n.t('orders.filter.canceled')
  }.freeze
  DEFAULT_SORT = 'created_at DESC'

  def initialize(user, params = {})
    @user = user
    @filter = params[:filter]
  end

  def call
    if ORDER_FILTERING.include?(@filter) && @filter != DEFAULT_SORT
      @user.orders.where(status: @filter)
    else
      @user.orders.order(DEFAULT_SORT)
    end
  end
end
