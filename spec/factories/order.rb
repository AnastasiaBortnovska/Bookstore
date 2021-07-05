# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    number { Order.generate_number }
  end

  trait :with_iteam do
    after(:create) do |order|
      create(:order_book, order: order)
    end
  end

  trait :with_user do
    after(:create) do |order|
      create(:user, orders: [order])
    end
  end

  trait :with_billing_address do
    after(:create) do |order|
      create(:address, :with_billing_type, order: order)
    end
  end

  trait :with_shipping_address do
    after(:create) do |order|
      create(:address, :with_shipping_type, order: order)
    end
  end

  trait :with_delivery do
    after(:create) do |order|
      create(:delivery, orders: [order])
    end
  end

  trait :with_credit_card do
    after(:create) do |order|
      create(:credit_card, order: order)
    end
  end

  trait :with_coupon do
    after(:create) do |order|
      create(:coupon, order: order)
    end
  end
end
