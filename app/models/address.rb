# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :first_name, :last_name, :country, :city, :address, :zip, :phone, :address_type, presence: true

  enum address_type: {
    billing: 0,
    shipping: 1
  }
end
