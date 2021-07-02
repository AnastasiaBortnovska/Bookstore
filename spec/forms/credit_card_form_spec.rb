RSpec.describe CreditCardForm, type: :model do
  let(:subject) {described_class.new(order)}
  let(:order) {create(:order, :with_credit_card)}
end
