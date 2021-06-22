# frozen_string_literal: true

RSpec.describe Order do
  describe 'associations' do
    it { is_expected.to belong_to(:user).without_validating_presence }
    it { is_expected.to have_one(:coupon).dependent(:destroy) }
    it { is_expected.to have_many(:order_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:order_books) }
  end

  describe 'status enum value' do
    it { expect(described_class.statuses[:in_progress]).to eq 0 }
    it { expect(described_class.statuses[:completed]).to eq 1 }
    it { expect(described_class.statuses[:in_delivery]).to eq 2 }
    it { expect(described_class.statuses[:delivered]).to eq 3 }
    it { expect(described_class.statuses[:canceled]).to eq 4 }
  end
end
