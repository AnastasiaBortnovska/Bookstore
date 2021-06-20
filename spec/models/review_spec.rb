# frozen_string_literal: true

RSpec.describe Review do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    it { expect(described_class.unprocessed).to eq(described_class.where(state: Review::STATE[:unprocessed])) }
    it { expect(described_class.approved).to eq(described_class.where(state: Review::STATE[:approved])) }
    it { expect(described_class.rejected).to eq(described_class.where(state: Review::STATE[:rejected])) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
