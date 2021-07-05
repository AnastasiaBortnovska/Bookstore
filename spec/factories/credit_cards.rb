# frozen_string_literal: true

FactoryBot.define do
  factory :credit_card do
    number { rand(9).to_s * 16 }
    name { FFaker::Name.first_name }
    cvv { rand(9).to_s * 3 }
    expire_date { "12/#{Time.zone.now.year.to_s.last(2)}" }
  end
end
