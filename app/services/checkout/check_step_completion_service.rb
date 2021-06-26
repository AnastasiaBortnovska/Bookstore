class Checkout::CheckStepCompletionService
    def initialize(order, user)
        @order = order
        @user = user
    end
    
    def call(step)
        case step
        when CheckoutController::STEPS[:address] then address
        when CheckoutController::STEPS[:delivery] then delivery
        when CheckoutController::STEPS[:credit_card] then credit_card
        end
    end

    def address
        @order.billing_address.present? && @order.shipping_address.present?
    end

    def delivery
      @order.delivery
    end

    def credit_card
      @order.credit_card
    end
end
