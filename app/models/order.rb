# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_one :order_delivery, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  has_one :coupon, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy

  validates :number, presence: true

  enum status: {
    in_progress: 0,
    completed: 1,
    in_delivery: 2,
    delivered: 3,
    canceled: 4
  }
end
