# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { rand(9).to_s * 4 }
    discount_percent { 10 }
    active { true }
  end
end
