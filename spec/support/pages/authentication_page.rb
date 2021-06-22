# frozen_string_literal: true

require_relative 'checkout_login_form'
require_relative 'quick_registation_form'

class AuthenticationPage < SitePrism::Page
  set_url 'checkout/authentication?destination=authentication'

  element :flash_failure, 'div.alert.alert-danger'

  section :login_form, CheckoutLoginForm, 'form.new_user'
  section :registration_form, QuickRegistrationForm, 'form.registration_form'

  expected_elements :login_form, :registration_form
end
