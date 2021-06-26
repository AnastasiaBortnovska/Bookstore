class CreditCardForm < Reform::Form

  property :credit_card, prepopulator: :build_credit_card, populate_if_empty: CreditCard do
    property :number
    property :name
    property :expire_date
    property :cvv

    validates :number, presence: true
  end

  private

  def build_credit_card(*)
    self.credit_card = CreditCard.new
  end
end
