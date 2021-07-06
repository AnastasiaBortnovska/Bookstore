# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    transient do
      authors_count { 2 }
    end

    title { FFaker::Book.title }
    price { rand(10.0..150.0).floor(2) }
    description { FFaker::Book.description(15) }
    publication_year { rand(2000...Time.zone.now.year) }
    height { rand(0.1...0.9).floor(1) }
    width { rand(0.1...0.9).floor(1) }
    depth { rand(0.1...0.9).floor(1) }
    material { FFaker::Skill.tech_skill }
    quantity { rand(50) }
    category
  end

  trait :with_authors do
    after(:create) do |book, evaluator|
      create_list(:author, evaluator.authors_count, books: [book])
    end
  end
end
