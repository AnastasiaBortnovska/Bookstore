# frozen_string_literal: true

class PasswordForm < SitePrism::Section
  element :input_current_password, '#user_current_password'
  element :input_new_password, '#user_password'
  element :input_password_confirmation, '#user_password_confirmation'
  element :button_save, 'input[type="submit"]'

  def fill_in(data)
    input_password_confirmation.set(data[:password])
    input_new_password.set(data[:password])
    input_current_password.set(data[:current_password])
    button_save.click
  end
end
