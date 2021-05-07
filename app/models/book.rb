# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  belongs_to :category, counter_cache: true

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :publication_year, presence: true
end
