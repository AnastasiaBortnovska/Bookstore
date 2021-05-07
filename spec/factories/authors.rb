# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    description { FFaker::Book.description(3) }
  end
end
