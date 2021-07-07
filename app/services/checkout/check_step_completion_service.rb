# frozen_string_literal: true

class Checkout::CheckStepCompletionService
  def initialize(order, step)
    @order = order
    @step = step
  end

  def call
    case @step
    when CheckoutController::STEPS[:address] then address
    when CheckoutController::STEPS[:delivery] then delivery
    when CheckoutController::STEPS[:payment] then payment
    when CheckoutController::STEPS[:confirm] then confirm
    when CheckoutController::STEPS[:complete] then complete
    end
  end

  def address
    @order.billing_address.present? && @order.shipping_address.present?
  end

  def delivery
    @order.delivery
  end

  def payment
    @order.credit_card
  end

  def confirm
    @order.completed?
  end

  def complete
    @order.nil?
  end
end
