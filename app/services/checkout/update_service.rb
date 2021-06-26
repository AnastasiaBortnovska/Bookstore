class Checkout::UpdateService
    def initialize(order, params)
        @order = order
        @params = params
    end

    def call(step)
        case step
        when CheckoutController::STEPS[:delivery] then delivery
        end
    end

    def delivery
      @order.update(delivery_id: @params[:order][:delivery_id])
    end
end
