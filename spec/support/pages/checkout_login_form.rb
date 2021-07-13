# frozen_string_literal: true

class CheckoutLoginForm < SitePrism::Section
  element :input_email, '#user_email'
  element :input_password, '#user_password'
  element :button, 'input[type="submit"]'
  element :link_forgot_password, 'a', text: I18n.t('checkout.partials.authentication.login_form.forgot_password')

  def fill_in(email, password)
    input_email.set(email)
    input_password.set(password)
    button.click
  end
end
