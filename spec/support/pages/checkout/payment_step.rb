# frozen_string_literal: true

class Checkout::PaymentStep < SitePrism::Page
  set_url '/checkout/payment'

  element :title, 'h3', text: I18n.t('checkout.payment.title')
  element :input_number_credit_card, '#payment_credit_card_number'
  element :input_name_credit_card, '#payment_credit_card_name'
  element :input_expire_date_credit_card, '#payment_credit_card_expire_date'
  element :input_cvv_credit_card, '#payment_credit_card_cvv'
  element :button_save_and_continue, "input[type='submit']"
  element :span_error, '.help-block'

  expected_elements :title, :input_number_credit_card, :input_name_credit_card, :input_expire_date_credit_card,
                    :input_cvv_credit_card, :button_save_and_continue

  def fill_in(**data)
    input_number_credit_card.set(data[:number])
    input_name_credit_card.set(data[:name])
    input_expire_date_credit_card.set(data[:expire_date])
    input_cvv_credit_card.set(data[:cvv])
    button_save_and_continue.click
  end
end
