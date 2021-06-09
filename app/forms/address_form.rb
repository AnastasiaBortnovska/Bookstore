# frozen_string_literal: true

class AddressForm
  include ActiveModel::Model
  include Virtus.model

  FORMATS = {
    text: /\A[a-zA-Z]*\z/,
    address: /\A[a-zA-Z0-9 \-,]*\z/,
    zip: /\A[0-9\-]*\z/,
    phone: /\A\+[0-9]*\z/
  }.freeze

  LENGTH = {
    text: 50,
    zip: 10,
    phone: 15
  }.freeze

  attribute :id, Integer
  attribute :first_name, String
  attribute :last_name, String
  attribute :country, String
  attribute :city, String
  attribute :address, String
  attribute :zip, Integer
  attribute :phone, String
  attribute :address_type, Integer

  validates :first_name, :last_name, :country, :city, :address, :zip, :phone, :address_type, presence: true

  validates :first_name, :last_name, :country, :city,
            format: { with: FORMATS[:text],
                      message: I18n.t('message.error.address.text_field') },
            length: { maximum: LENGTH[:text] }

  validates :address,
            format: { with: FORMATS[:address],
                      message: I18n.t('message.error.address.address_field') },
            length: { maximum: LENGTH[:text] }

  validates :zip,
            format: { with: FORMATS[:zip],
                      message: I18n.t('message.error.address.zip_field') },
            length: { maximum: LENGTH[:zip] }

  validates :phone,
            format: { with: FORMATS[:phone],
                      message: I18n.t('message.error.address.phone_field') },
            length: { maximum: LENGTH[:phone] }

  def save(object)
    return false unless valid?

    current_address = object.addresses.where(address_type: address_type).first
    return object.addresses.create(params) unless current_address

    object.addresses.update(params)
  end

  private

  def params
    {
      first_name: first_name,
      last_name: last_name,
      country: country,
      city: city,
      address: address,
      zip: zip,
      phone: phone,
      address_type: address_type
    }
  end
end
