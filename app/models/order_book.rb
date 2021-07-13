# frozen_string_literal: true

class OrderBook < ApplicationRecord
  belongs_to :order
  belongs_to :book
end
