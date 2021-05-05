# frozen_string_literal: true

RSpec.describe Book do
  describe 'associations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:book_authors) }
    it { is_expected.to belong_to(:category) }
  end
end
