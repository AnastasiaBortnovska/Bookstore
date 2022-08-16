# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

  rescue_from Stripe::CardError, with: :catch_exception

  STEPS = {
    authentication: :authentication,
    address: :address,
    delivery: :delivery,
    payment: :payment,
    confirm: :confirm,
    complete: :complete
  }.freeze

  steps STEPS[:authentication], STEPS[:address], STEPS[:delivery], STEPS[:payment], STEPS[:confirm],
        STEPS[:complete]

  def show
    case step
    when STEPS[:authentication] then jump_to(next_step) if user_signed_in?
    when STEPS[:address] then create_form
    when STEPS[:delivery] then @deliveries = Delivery.all
    when STEPS[:payment] then jump_to(next_step) if current_order.credit_card
    end

    render_wizard
  end

  def update
    return payment_sesion if step == STEPS[:payment]

    Checkout::UpdateService.new(current_order, params, session).call(step)
    return update_form if create_form

    return render_wizard unless complete_step?
    return redirect_to books_path if step == STEPS[:complete]

    redirect_to next_wizard_path
  end

  private

  def payment_sesion
    card = StripeChargesService.new(charges_params, current_order).call
    Checkout::UpdateService.new(current_order, card, session).call(step)
    redirect_to next_wizard_path
  end

  def catch_exception(exception)
    flash[:alert] = exception.message
    render_wizard
  end

  def create_form
    @form = Checkout::CreateFormService.new(current_order, step).call
    @form&.prepopulate!
  end

  def update_form
    return render_wizard unless @form.validate(params[step])

    use_billing_address if step == STEPS[:address]

    @form.save
    redirect_to next_wizard_path
  end

  def complete_step?
    Checkout::CheckStepCompletionService.new(current_order, step).call
  end

  def use_billing_address
    return current_order.update(use_billing: true) if params[:shipping_address].present?

    current_order.update(use_billing: false)
  end

  def charges_params
    params.permit(:stripeEmail, :stripeToken)
  end
end
