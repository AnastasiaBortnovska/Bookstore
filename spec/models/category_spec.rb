# frozen_string_literal: true

RSpec.describe Category do
  describe 'associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  describe 'validation' do
    subject { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
