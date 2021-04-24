# frozen_string_literal: true

RSpec.describe Category do
  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:books_count).of_type(:integer) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
