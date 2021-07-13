# frozen_string_literal: true

class CreditCard < ApplicationRecord
  belongs_to :order
end
