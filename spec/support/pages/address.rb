# frozen_string_literal: true

require_relative 'form_address'

class AddressPage < SitePrism::Page
  set_url '/users/edit{.user_id}'

  element :settings, 'h1', text: I18n.t('devise.registrations.edit.settings')
  element :tab_address, 'a', text: I18n.t('devise.registrations.edit.tab_address')
  element :tab_privacy, 'a', text: I18n.t('devise.registrations.edit.tab_privacy')
  element :billing_address, 'h3', text: I18n.t('devise.registrations.edit.billing_address')
  element :shipping_address, 'h3', text: I18n.t('devise.registrations.edit.shipping_address')

  element :flash_success, 'div.alert.alert-success'
  element :flash_failure, 'div.alert.alert-danger'

  section :billing_address_section, FormAddress, '.col-md-5.mb-40'
  section :shipping_address_section, FormAddress, '.col-md-5.col-md-offset-1.mb-25'

  expected_elements :settings, :tab_address, :tab_privacy, :billing_address, :shipping_address,
                    :billing_address_section, :shipping_address_section
end
