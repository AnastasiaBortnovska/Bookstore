# frozen_string_literal: true

class StripeChargesService
  def initialize(params, order)
    @stripe_token = params[:stripeToken]
    @order = order
    @user = order.user
  end

  def call
    StripeAdapter.create_payment_intent(find_customer, @order.decorate.total_price)
  end

  private

  def find_customer
    return StripeAdapter.update_customer_source(@user, @stripe_token) if @user.stripe_token

    StripeAdapter.create_customer(@user)
  end
end
