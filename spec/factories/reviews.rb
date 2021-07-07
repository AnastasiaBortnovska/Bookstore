# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    body { FFaker::Book.description(5) }
    score { rand(1..5) }
    book
    user
  end

  trait :approved do
    state { Review::STATE[:approved] }
  end
end
