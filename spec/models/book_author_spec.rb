# frozen_string_literal: true

RSpec.describe BookAuthor do
  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:book) }
  end
end
