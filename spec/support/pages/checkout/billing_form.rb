class Checkout::BillingForm < SitePrism::Section
  element :input_first_name, '#address_billing_address_first_name'
  element :input_last_name, '#address_billing_address_last_name'
  element :input_country, '#address_billing_address_country'
  element :input_city, '#address_billing_address_city'
  element :input_address, '#address_billing_address_address'
  element :input_zip, '#address_billing_address_zip'
  element :input_phone, '#address_billing_address_phone'
  element :span_error, 'span.help-block'

  expected_elements :input_first_name, :input_last_name, :input_country, :input_city, :input_address, :input_zip, :input_phone
  def fill_in(data)
    input_first_name.set(data[:first_name])
    input_last_name.set(data[:last_name])
    input_phone.set(data[:phone])
    fill_address_data(data)
  end

  private

  def fill_address_data(data)
    input_country.select(data[:country])
    input_city.set(data[:city])
    input_address.set(data[:address])
    input_zip.set(data[:zip])
  end
end
