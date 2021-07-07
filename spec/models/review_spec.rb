# frozen_string_literal: true

RSpec.describe Review do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    it { expect(described_class.unprocessed).to eq(described_class.where(state: 0)) }
    it { expect(described_class.approved).to eq(described_class.where(state: 2)) }
    it { expect(described_class.rejected).to eq(described_class.where(state: 1)) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
