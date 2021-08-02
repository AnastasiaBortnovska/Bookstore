# frozen_string_literal: true

class Checkout::ConfirmPayment < SitePrism::Section
  element :payment_information, 'p'
  element :edit_link, 'span#edit_credit_card a', text: I18n.t('checkout.partials.confirm.payment_information.edit')
end
