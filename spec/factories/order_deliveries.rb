# frozen_string_literal: true

FactoryBot.define do
  factory :order_delivery do
    order
    delivery
  end
end
