# frozen_string_literal: true

require 'faker'

BOOK_MATERIAL = ['hardcover', 'glossy paper', 'matte paper'].freeze
CATEGORIES = ['Mobile Development', 'Photo', 'Web Desing', 'Web Development'].freeze

if Rails.seeds_enabled

  20.times { Author.create(name: Faker::Book.author) }

  CATEGORIES.each do |category|
    Category.create(name: category)
  end

  15.times do
    book = Book.create(
      name: Faker::Book.title,
      price: Faker::Number.decimal(l_digits: 2),
      description: Faker::Books::Lovecraft.paragraph(sentence_count: 5),
      publication_year: Faker::Number.between(from: 2000, to: Time.zone.now.year),
      height: Faker::Number.decimal(l_digits: 1, r_digits: 1),
      width: Faker::Number.decimal(l_digits: 1, r_digits: 1),
      depth: Faker::Number.decimal(l_digits: 1, r_digits: 1),
      material: BOOK_MATERIAL.sample,
      quantity: Faker::Number.number(digits: 2),
      category_id: Category.all.sample.id
    )
    book.authors << Author.all.sample(rand(1..3))
  end
end
