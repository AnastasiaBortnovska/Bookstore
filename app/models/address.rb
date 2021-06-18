# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :country, :city, :address, :zip, :phone, :type, presence: true
end
