# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :code, presence: true

  scope :active,   -> { where active: true }
  scope :inactive, -> { where active: false }
end
