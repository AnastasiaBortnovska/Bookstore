# frozen_string_literal: true

class Checkout::CreateFormService
  def initialize(order, step)
    @order = order
    @step = step
  end

  def call
    case @step
    when CheckoutController::STEPS[:address] then address
    when CheckoutController::STEPS[:credit_card] then credit_card
    end
  end

  def address
    AddressForm.new(@order)
  end

  def credit_card
    CreditCardForm.new(@order)
  end
end
