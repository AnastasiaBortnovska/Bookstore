class Checkout::ShowService
  attr_reader :deliveries

    def initialize(order, user)
        @order = order
        @user = user
    end

    def call(step)
        case step
        when CheckoutController::STEPS[:delivery] then delivery
        end
    end
    
    def delivery
      @deliveries = Delivery.all
    end
end
