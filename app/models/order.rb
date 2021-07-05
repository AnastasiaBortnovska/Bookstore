# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  NUMBER_PREFIX = '#R'
  DATE_FORMAT = '%Y%m%d%H%M%S'

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

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

  aasm :status, column: :status, enum: true do
    state :in_progress, initial: true
    state :completed
    state :in_delivery
    state :delivered
    state :canceled

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end

  def self.generate_number
    NUMBER_PREFIX + Time.zone.now.strftime(DATE_FORMAT)
  end
end
