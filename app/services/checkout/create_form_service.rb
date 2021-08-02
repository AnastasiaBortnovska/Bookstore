# frozen_string_literal: true

class Checkout::CreateFormService
  def initialize(order, step)
    @order = order
    @step = step
  end

  def call
    case @step
    when CheckoutController::STEPS[:address] then address
    when CheckoutController::STEPS[:payment] then payment
    end
  end

  def address
    AddressForm.new(@order)
  end

  def payment
    PaymentForm.new(@order)
  end
end
