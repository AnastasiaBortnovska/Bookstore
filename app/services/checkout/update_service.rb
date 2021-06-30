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
      @order.update(delivery_id: @params[:order][:delivery_id])
    end

    def confirm
      @order.complete
      OrderMailer.completed_order(@order).deliver
    end

    def complete
      @session.delete(:order_id)
    end
end
