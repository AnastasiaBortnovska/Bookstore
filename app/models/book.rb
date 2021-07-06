# frozen_string_literal: true

class Book < ApplicationRecord
  include ImageUploader::Attachment(:cover)

  MAXIMUM_NAME_LENGTH = 50
  NAME_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])/x.freeze

  has_many :book_photos, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy
  has_many :orders, through: :order_books
  belongs_to :category, counter_cache: true

  accepts_nested_attributes_for :book_photos, allow_destroy: true

  validates :title, :price, :description, :publication_year, presence: true
  validates :title, format: { with: NAME_FORMAT }, length: { maximum: MAXIMUM_NAME_LENGTH }
end
