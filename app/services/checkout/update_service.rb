# frozen_string_literal: true

class Checkout::UpdateService
  def initialize(order, params, session)
    @order = order
    @params = params
    @session = session
  end

  def call(step)
    case step
    when CheckoutController::STEPS[:delivery] then delivery
    when CheckoutController::STEPS[:confirm] then confirm
    when CheckoutController::STEPS[:complete] then complete
    end
  end

  def delivery
    return @order.order_delivery.update(delivery_id: @params[:order][:delivery_id]) if @order.order_delivery.present?

    @order.build_order_delivery(delivery_id: @params[:order][:delivery_id]).save
  end

  def confirm
    @order.update(status: :completed)
    OrderCompletedMailerWorker.perform_async(@order.id)
  end

  def complete
    @session.delete(:order_id)
  end
end
