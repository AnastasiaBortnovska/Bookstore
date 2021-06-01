# frozen_string_literal: true

class LogIn < SitePrism::Page
  set_url '/users/sign_in'

  element :title, 'h3.general-subtitle', text: I18n.t('devise.sessions.new.log_in')
  element :facebook_link, 'button.general-login-icon'
  element :input_email, 'input[name="user[email]"]'
  element :input_password, 'input[name="user[password]"]'
  element :button_log_in, 'input[type="submit"]'
  element :forgot_password, 'a', text: I18n.t('devise.sessions.new.forgot_password')
  element :checkbox_remember, 'span.checkbox-text', text: I18n.t('devise.sessions.new.remember_me')
  element :link_sing_up, 'a', text: I18n.t('devise.sessions.new.sign_up')

  expected_elements :title, :facebook_link, :input_email, :input_password, :button_log_in, :forgot_password,
                    :checkbox_remember, :link_sing_up

  def sign_in!(email, password)
    input_email.set(email)
    input_password.set(password)
    button_log_in.click
  end
end
