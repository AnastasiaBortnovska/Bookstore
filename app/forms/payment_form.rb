# frozen_string_literal: true

class PaymentForm < Reform::Form
  CARD_LENGTH = 16
  NAME_FORMAT = /\A[a-zA-Z ]*\z/.freeze
  NAME_LENGTH = 50
  DATE_FORMAT = %r{\A^(0[1-9]|1[0-2])/?([0-9]{2})$\z}.freeze
  CVV_RANGE = (3..4).freeze

  property :credit_card, prepopulator: :build_credit_card, populate_if_empty: CreditCard do
    properties :number, :name, :expire_date, :cvv

    validates :number, :name, :expire_date, :cvv, presence: true
    validates :number, length: { is: CARD_LENGTH }, numericality: { only_integer: true }
    validates :name, length: { maximum: NAME_LENGTH },
                     format: { with: NAME_FORMAT, message: I18n.t('message.error.credit_card.name') }
    validates :expire_date, format: { with: DATE_FORMAT, message: I18n.t('message.error.credit_card.expire_date') }
    validates :cvv, length: { in: CVV_RANGE }, numericality: { only_integer: true }
  end

  private

  def build_credit_card(*)
    return if credit_card

    self.credit_card = CreditCard.new
  end
end
