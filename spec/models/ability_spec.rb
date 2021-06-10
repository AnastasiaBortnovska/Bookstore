# frozen_string_literal: true

RSpec.describe Ability do
  subject(:ability) { described_class.new(user) }

  describe 'when user is persisted' do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to %i[show update destroy], User, id: user.id }
    it { is_expected.to be_able_to %i[create update], Address, addressable_id: user.id, addressable_type: 'User' }
  end

  describe 'when user is not logged in' do
    let(:user) { build(:user) }

    it { is_expected.to be_able_to %i[index show], Book }
  end
end
