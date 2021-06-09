# frozen_string_literal: true

class ForgotPasswordPage < SitePrism::Page
  set_url '/users/password/new'

  element :title, 'h1.mb-30', text: I18n.t('devise.passwords.new.forgot_password')
  element :description, '.general-password-text', text: I18n.t('devise.passwords.new.forgot_password_description')
  element :input_email, '#user_email'
  element :button_submit, 'input[type="submit"]'
  element :link_cancel, 'a', text: I18n.t('devise.passwords.new.cancel')

  element :span_error, 'span.help-block', text: I18n.t('errors.messages.not_found')

  expected_elements :title, :description, :input_email, :button_submit, :link_cancel

  def fill_form(email)
    input_email.set(email)
    button_submit.click
  end
end
