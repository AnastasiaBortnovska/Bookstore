# frozen_string_literal: true

class Book < ApplicationRecord
  include ImageUploader::Attachment(:cover)
  include ImageUploader::Attachment(:images)

  MAXIMUM_NAME_LENGTH = 50
  NAME_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])/x.freeze

  has_one_attached :cover
  has_many_attached :images
  #has_many :photos
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy
  belongs_to :category, counter_cache: true

  #accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :price, :description, :publication_year, presence: true
  validates :title, format: { with: NAME_FORMAT }, length: { maximum: MAXIMUM_NAME_LENGTH }
end
