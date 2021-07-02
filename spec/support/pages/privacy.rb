# frozen_string_literal: true

require_relative 'remove_account_form'

class PrivacyPage < SitePrism::Page
  set_url '/users/edit{.user_id}'

  element :email, 'p', text: I18n.t('devise.registrations.partials.email_form.email')
  element :password, 'p', text: I18n.t('devise.registrations.partials.password_form.password')
  element :remove_account, 'p', text: I18n.t('devise.registrations.partials.delete_form.remove_account')

  section :email_form, EmailForm, '#email_form'
  section :password_form, PasswordForm, '#password_form'
  section :remove_account_form, RemoveAccountForm, '#remove_account'
end
