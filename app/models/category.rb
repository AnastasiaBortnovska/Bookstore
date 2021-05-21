# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_commit :clear_cache

  private

  def clear_cache
    Rails.cache.delete('all_categories')
  end
end
