# frozen_string_literal: true

class Order < ApplicationRecord
  NUMBER_PREFIX = '#R'

  belongs_to :user, optional: true

  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  has_one :coupon, dependent: :destroy

  validates :number, presence: true

  enum status: {
    in_progress: 0,
    completed: 1,
    in_delivery: 2,
    delivered: 3,
    canceled: 4
  }
  def self.generate_number
    NUMBER_PREFIX + I18n.l(Time.zone.now, format: :order_create_date)
  end
end
