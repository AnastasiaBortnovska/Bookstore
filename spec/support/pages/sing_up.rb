# frozen_string_literal: true

class SingUp < SitePrism::Page
  set_url '/users/sign_up'

  element :title, 'h3.general-subtitle', text: I18n.t('devise.registrations.new.sign_up')
  element :facebook_link, 'button.general-login-icon'
  element :input_email, 'input[name="user[email]"]'
  element :input_password, 'input[name="user[password]"]'
  element :input_confirm_password, 'input[name="user[confirm_password]"]'
  element :button_sing_up, 'input[type="submit"]'
  element :have_account, 'p.general-sign-text', text: I18n.t('devise.registrations.new.have_account')
  element :login_in_link, 'a.in-gold-500', text: I18n.t('devise.registrations.new.log_in')

  def sign_in!(data)
    input_email.set(data[:email])
    input_password.set(data[:password])
    input_confirm_password.set(data[:password])
    button_sing_up.click
  end
end
