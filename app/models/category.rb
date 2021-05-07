# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_save :clear_cache
  after_destroy :clear_cache

  def clear_cache
    Rails.cache.delete('all_categories')
  end

  def self.set_cache
    Rails.cache.fetch('all_categories') { Category.all }
  end
end
