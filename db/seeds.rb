# frozen_string_literal: true

require 'ffaker'

BOOK_MATERIAL = ['hardcover', 'glossy paper', 'matte paper'].freeze
CATEGORIES = ['Mobile Development', 'Photo', 'Web Desing', 'Web Development'].freeze

['Nova Poshta', 'Ukr Poshta', 'DHL'].each do |name|
  Delivery.create(
    name: name,
    days: rand(14),
    price: rand(10.0..50.0).floor(2)
  )
end

CATEGORIES.each do |category|
  Category.create(name: category)
end

20.times do
  Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
                description: FFaker::Book.description(5))
end

15.times do
  book = Book.create(
    title: FFaker::Book.title,
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

AdminUser.create(email: 'admin@example.com', password: 'password')

7.times { |index| Coupon.create(code: index.to_s * 4, discount_percent: rand(1..10)) }
