# frozen_string_literal: true

class StripeChargesService
  DEFAULT_CURRENCY = 'usd'

  def initialize(params, order)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @order = order
    @user = order.user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def find_customer
    user.stripe_token ? update_customer_source : create_customer
  end

  def update_customer_source
    Stripe::Customer.update(user.stripe_token, { source: retrieve_token }).id
  end

  def create_customer
    customer = Stripe::Customer.create(email: stripe_email)
    user.update(stripe_token: customer.id)
    customer.id
  end

  def retrieve_token
    Stripe::Token.retrieve(stripe_token)
  end

  def create_charge(customer)
    Stripe::Charge.create(
      source: retrieve_token.card.id,
      customer: customer,
      amount: (order.decorate.total_price * 100).to_i,
      description: stripe_email,
      currency: DEFAULT_CURRENCY
    )
  end
end
