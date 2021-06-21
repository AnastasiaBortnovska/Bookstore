# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_FORMAT = /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/x.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_many :orders, dependent: :destroy

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  validate :password_regex

  def self.from_omniauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def password_regex
    return unless password.present? && !password.match(PASSWORD_FORMAT)

    errors.add :password, I18n.t('message.error.user.wrong_format')
  end
end
