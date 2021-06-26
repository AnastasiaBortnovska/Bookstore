# frozen_string_literal: true

class Address < ApplicationRecord
  MAXIMUM_TEXT_LENGTH = 50
  MAXIMUM_ZIP_LENGTH = 10
  MAXIMUM_PHONE_LENGTH = 15
  ADDRESS_FORMAT = /\A[a-zA-Z0-9 \-,]*\z/.freeze
  ZIP_FORMAT = /\A[0-9\-]*\z/.freeze
  PHONE_NUMBER_FORMAT = /\A\+[0-9]*\z/.freeze
  TEXT_FORMAT = /\A[a-zA-Z]*\z/.freeze
  COUNTRY_FORMAT = /\A[a-zA-Z ]*\z/.freeze

  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :first_name, :last_name, :country, :city, :address, :zip, :phone, :type, presence: true
  validates :first_name, :last_name, :city, length: { maximum: MAXIMUM_TEXT_LENGTH },
                                            format: { with: TEXT_FORMAT }
  validates :zip, length: { maximum: MAXIMUM_ZIP_LENGTH }, format: { with: ZIP_FORMAT }
  validates :phone, length: { maximum: MAXIMUM_PHONE_LENGTH }, format: { with: PHONE_NUMBER_FORMAT }
  validates :address, length: { maximum: MAXIMUM_TEXT_LENGTH }, format: { with: ADDRESS_FORMAT }
  validates :country, length: { maximum: MAXIMUM_TEXT_LENGTH }, format: { with: COUNTRY_FORMAT }
end
