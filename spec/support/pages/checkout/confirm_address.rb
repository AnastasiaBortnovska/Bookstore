# frozen_string_literal: true

class Checkout::ConfirmAddress < SitePrism::Section
  element :adress_information, 'p'
  element :edit_link, 'a', text: I18n.t('checkout.partials.confirm.address_information.edit')
end
