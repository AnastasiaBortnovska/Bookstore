# frozen_string_literal: true

class Delivery < ApplicationRecord
  has_many :order_deliveries, dependent: :destroy
  has_many :ordes, through: :order_deliveries
end
