# frozen_string_literal: true

RSpec.describe Order do
  describe 'associations' do
    it { is_expected.to belong_to(:user).without_validating_presence }
    it { is_expected.to have_one(:coupon).dependent(:destroy) }
    it { is_expected.to have_one(:credit_card).dependent(:destroy) }
    it { is_expected.to have_one(:order_delivery).dependent(:destroy) }
    it { is_expected.to have_many(:order_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:order_books) }
  end

  describe 'status enum value' do
    it do
      expect(subject).to define_enum_for(:status)
        .with_values(in_progress: 0, completed: 1, in_delivery: 2, delivered: 3, canceled: 4)
    end
  end
end
