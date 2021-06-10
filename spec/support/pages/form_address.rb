# frozen_string_literal: true

class FormAddress < SitePrism::Section
  element :input_first_name, '#address_form_first_name'
  element :input_last_name, '#address_form_last_name'
  element :input_country, '#address_form_country'
  element :input_city, '#address_form_city'
  element :input_address, '#address_form_address'
  element :input_zip, '#address_form_zip'
  element :input_phone, '#address_form_phone'
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
