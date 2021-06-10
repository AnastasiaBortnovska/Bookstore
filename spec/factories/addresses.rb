# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    country { FFaker::Address.country }
    city { FFaker::AddressUS.city.delete(' ') }
    address { FFaker::Address.street_name }
    zip { FFaker::AddressBR.zip_code }
    phone { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/\s/, '').delete('-') }

    trait :billing do
      address_type { 0 }
    end

    trait :shipping do
      address_type { 1 }
    end
  end
end
