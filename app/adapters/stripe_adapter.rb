# frozen_string_literal: true

class StripeAdapter
  DEFAULT_CURRENCY = 'usd'

  class << self
    def update_customer_source(user, token)
      Stripe::Customer.update(user.stripe_token, { source: token })
    end

    def create_customer(user)
      customer = Stripe::Customer.create(email: user.email)
      user.update(stripe_token: customer.id)
      customer
    end

    def find_charges(charge_id)
      Stripe::Charge.retrieve(charge_id)
    end

    def create_payment_intent(customer, amount)
      Stripe::PaymentIntent.create(
        customer: customer.id,
        amount: amount_in_integer(amount),
        confirm: true,
        payment_method_types: ['card'],
        currency: DEFAULT_CURRENCY
      )
    end

    private

    def amount_in_integer(amount)
      (amount * 100).to_i
    end
  end
end
