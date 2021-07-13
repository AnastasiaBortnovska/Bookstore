# frozen_string_literal: true

FactoryBot.define do
  factory :order_book do
    quantity { rand(5) }
    book
    order
  end
end
