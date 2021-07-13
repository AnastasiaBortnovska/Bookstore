# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    number { Order::GenerateOrderNumberService.new.call }
  end

  trait :with_iteam do
    after(:create) do |order|
      create(:order_book, order: order)
    end
  end
end
