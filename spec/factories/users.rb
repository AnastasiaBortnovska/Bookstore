# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::String.from_regexp(User::PASSWORD_FORMAT) }

    trait :with_provider do
      provider { 'facebook' }
    end

    trait :with_uid do
      uid { rand(5) }
    end

    trait :with_billing_address do
      after(:create) do |user|
        create(:address, :with_billing_type, user: user)
      end
    end
  end
end
