# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    country { 'Aruba' }
    city { FFaker::String.from_regexp(Address::TEXT_FORMAT) }
    address { FFaker::Address.street_name }
    zip { FFaker::AddressBR.zip_code }
    phone { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/\s/, '').delete('-') }

    trait :with_billing_type do
      type { 'BillingAddress' }
    end

    trait :with_shipping_type do
      type { 'ShippingAddress' }
    end
  end
end
