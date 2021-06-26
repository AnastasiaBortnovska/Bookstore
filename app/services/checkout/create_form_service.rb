class Checkout::CreateFormService
  
  def initialize(order, step)
    @order = order
    @step = step
  end

  def call
    case @step
    when :address then address
    when :credit_card then credit_card
    end
  end

  def address
    AddressForm.new(@order)
  end

  def credit_card
    CreditCardForm.new(@order)
  end
end
