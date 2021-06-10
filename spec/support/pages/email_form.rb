# frozen_string_literal: true

class EmailForm < SitePrism::Section
  element :input_email, '#user_email'
  element :button_save, 'input[type="submit"]'

  def fill_in(email)
    input_email.set email
    button_save.click
  end
end
