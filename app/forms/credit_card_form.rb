class CreditCardForm < Reform::Form
  CARD_LENGTH = 16
  NAME_FORMAT = /\A[a-zA-Z ]*\z/.freeze
  NAME_LENGTH = 50
  DATE_FORMAT = /\A^(0[1-9]|1[0-2])\/?([0-9]{2})$\z/
  CVV_RANGE = (3..4)

  property :credit_card, prepopulator: :build_credit_card, populate_if_empty: CreditCard do
    property :number
    property :name
    property :expire_date
    property :cvv

    validates :number, :name, :expire_date, :cvv, presence: true
    validates :number, length: { is: CARD_LENGTH }, numericality: { only_integer: true }
    validates :name, length: { maximum: NAME_LENGTH }, format: { with: NAME_FORMAT, message: "Must consist of a-z, A-Z, no special symbols" }
    validates :expire_date, format: { with: DATE_FORMAT, message: "Must have a month on the left of a slash /, the year on the right" }
    validates :cvv, length: { in: CVV_RANGE}, numericality: { only_integer: true }
  end

  private

  def build_credit_card(*)
    self.credit_card = CreditCard.new
  end
end
