# frozen_string_literal: true

class Author < ApplicationRecord
  MAXIMUM_NAME_LENGTH = 50
  NAME_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])/x.freeze

  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  validates :first_name, presence: true, format: { with: NAME_FORMAT }, length: { maximum: MAXIMUM_NAME_LENGTH }
  validates :last_name, presence: true, format: { with: NAME_FORMAT }, length: { maximum: MAXIMUM_NAME_LENGTH }
end
