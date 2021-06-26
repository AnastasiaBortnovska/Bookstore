# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

  STEPS = {
    authentication: :authentication,
    address: :address,
    delivery: :delivery,
    credit_card: :credit_card,
    confirm: :confirm
  }.freeze

  steps STEPS[:authentication], STEPS[:address], STEPS[:delivery], STEPS[:credit_card], STEPS[:confirm] 

  def show
    jump_to(next_step) if user_signed_in? && authentication_step?
    create_form if needs_form?
    @checkout = Checkout::ShowService.new(current_order, current_user)
    @checkout.call(step)

    render_wizard
  end

  def update 
    Checkout::UpdateService.new(current_order, params).call(step)
    update_form if needs_form?
    
    if complete_step?
      redirect_to next_wizard_path
    else
      render_wizard
    end
end

  private

  def create_form
    @form = Checkout::CreateFormService.new(current_order, step).call
    @form&.prepopulate!
  end

  def update_form
    create_form
    @form.save if @form.validate(params[step])
  end

  def needs_form?
    step == STEPS[:address] || step == STEPS[:credit_card]
  end

  def authentication_step?
    step == STEPS[:authentication]
  end

  def complete_step?
    Checkout::CheckStepCompletionService.new(current_order, current_user).call(step)
  end
end
