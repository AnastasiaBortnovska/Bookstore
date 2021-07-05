# frozen_string_literal: true

class CreditCard < ApplicationRecord
  has_one :order, dependent: :destroy
end
