# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  validates :first_name, presence: true
  validates :last_name, presence: true
end
