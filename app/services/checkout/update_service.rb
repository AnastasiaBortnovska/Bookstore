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
    when CheckoutController::STEPS[:payment] then payment
    end
  end

  def delivery
    return @order.order_delivery.update(delivery_id: @params[:order][:delivery_id]) if @order.order_delivery.present?

    @order.build_order_delivery(delivery_id: @params[:order][:delivery_id]).save
  end

  def confirm
    @order.update(status: :completed)
    OrderMailer.completed_order(@order).deliver
  end

  def complete
    @session.delete(:order_id)
  end

  def payment
    exp_date = "#{charge.payment_method_details.card.exp_month}/#{charge.payment_method_details.card.exp_year}"
    credit_card = CreditCard.create(name: charge.billing_details.name, number: charge.payment_method_details.card.last4,
                                    expire_date: exp_date)
    @order.update(credit_card: credit_card)
  end

  private

  def charge
    @charge ||= StripeAdapter.find_charges(@params.charges.data[0].id)
  end
end
