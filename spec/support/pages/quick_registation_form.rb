# frozen_string_literal: true

class QuickRegistrationForm < SitePrism::Section
  element :input_email, '#user_email'
  element :button, 'input[type="submit"]'

  def fill_in(email)
    input_email.set(email)
    button.click
  end
end
