# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

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
    when STEPS[:payment] then create_form
    end

    render_wizard
  end

  def update
    Checkout::UpdateService.new(current_order, params, session).call(step)
    return update_form if create_form

    return render_wizard unless complete_step?
    return redirect_to books_path if step == STEPS[:complete]

    redirect_to next_wizard_path
  end

  private

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
end
