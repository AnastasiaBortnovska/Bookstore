# frozen_string_literal: true

require_relative 'billing_form_address'
require_relative 'shipping_form_address'

class AddressPage < SitePrism::Page
  set_url '/users/edit{.user_id}'

  element :settings, 'h1', text: I18n.t('devise.registrations.edit.settings')
  element :tab_address, 'a', text: I18n.t('devise.registrations.edit.tab_address')
  element :tab_privacy, 'a', text: I18n.t('devise.registrations.edit.tab_privacy')
  element :billing_address, 'h3', text: I18n.t('devise.registrations.edit.billing_address')
  element :shipping_address, 'h3', text: I18n.t('devise.registrations.edit.shipping_address')

  element :flash_success, '.alert-success'
  element :span_failure, 'span.help-block'

  section :billing_address_section, BillingFormAddress, '#billing_form'
  section :shipping_address_section, ShippingFormAddress, '#shipping_form'

  expected_elements :settings, :tab_address, :tab_privacy, :billing_address, :shipping_address,
                    :billing_address_section, :shipping_address_section
end
