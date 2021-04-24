# frozen_string_literal: true

require 'ffaker'
require 'factory_bot_rails'

BOOK_MATERIAL = ['hardcover', 'glossy paper', 'matte paper'].freeze
CATEGORIES = ['Mobile Development', 'Photo', 'Web Desing', 'Web Development'].freeze

if Rails.application.config.seeds_enabled
  20.times do
    FactoryBot.create :book, :attach_author
  end
end

unless Rails.application.config.seeds_enabled
  20.times { Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }

  CATEGORIES.each do |category|
    Category.create(name: category)
  end

  15.times do
    book = Book.create(
      name: FFaker::Book.title,
      price: rand(10.0..150.0).floor(2),
      description: FFaker::Book.description(15),
      publication_year: rand(2000...Time.zone.now.year),
      height: rand(0.1...0.9).floor(1),
      width: rand(0.1...0.9).floor(1),
      depth: rand(0.1...0.9).floor(1),
      material: BOOK_MATERIAL.sample,
      quantity: rand(50),
      category_id: Category.all.sample.id
    )
    book.authors << Author.all.sample(rand(1..3))
  end
end
