class CreditCard < ApplicationRecord
  has_one :order, dependent: :destroy
end
