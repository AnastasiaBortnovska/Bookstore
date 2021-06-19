# frozen_string_literal: true

class ShippingFormAddress < SitePrism::Section
  element :input_first_name, '#user_shipping_address_attributes_first_name'
  element :input_last_name, '#user_shipping_address_attributes_last_name'
  element :input_country, '#user_shipping_address_attributes_country'
  element :input_city, '#user_shipping_address_attributes_city'
  element :input_address, '#user_shipping_address_attributes_address'
  element :input_zip, '#user_shipping_address_attributes_zip'
  element :input_phone, '#user_shipping_address_attributes_phone'
  element :button_save, 'input[type="submit"]'

  def fill_in(data)
    input_first_name.set(data[:first_name])
    input_last_name.set(data[:last_name])
    input_phone.set(data[:phone])
    fill_address_data(data)
    button_save.click
  end

  private

  def fill_address_data(data)
    input_country.select(data[:country])
    input_city.set(data[:city])
    input_address.set(data[:address])
    input_zip.set(data[:zip])
  end
end
