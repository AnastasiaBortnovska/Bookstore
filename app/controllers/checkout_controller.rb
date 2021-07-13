# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

  STEPS = {
    authentication: :authentication,
    addresses: :addresses
  }.freeze

  steps STEPS[:authentication], STEPS[:addresses]

  def show
    jump_to(next_step) if user_signed_in? && authentication_step?

    render_wizard
  end

  private

  def authentication_step?
    step == STEPS[:authentication]
  end
end
