# frozen_string_literal: true

class Book < ApplicationRecord
  MAXIMUM_NAME_LENGTH = 50
  NAME_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])/x.freeze

  has_one_attached :cover
  has_many_attached :images
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy
  belongs_to :category, counter_cache: true

  validates :title, :price, :description, :publication_year, presence: true
  validates :title, format: { with: NAME_FORMAT }, length: { maximum: MAXIMUM_NAME_LENGTH }
end
