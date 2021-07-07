# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, :body, presence: true

  scope :unprocessed, -> { where state: :unprocessed }
  scope :approved, -> { where state: :approved }
  scope :rejected, -> { where state: :rejected }

  enum state: { unprocessed: 0, rejected: 1, approved: 2 }
end
