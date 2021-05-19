# frozen_string_literal: true

RSpec.describe Book do
  describe 'associations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:book_authors) }
    it { is_expected.to belong_to(:category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:publication_year) }
    it { is_expected.to validate_length_of(:title).is_at_most(Book::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(Book::NAME_FORMAT)).for(:title) }
  end
end
