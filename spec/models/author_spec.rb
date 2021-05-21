# frozen_string_literal: true

RSpec.describe Author do
  describe 'associations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:book_authors) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(Author::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(Author::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(Author::NAME_FORMAT)).for(:first_name) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(Author::NAME_FORMAT)).for(:last_name) }
    it { is_expected.not_to allow_value(rand(50)).for(:last_name) }
    it { is_expected.not_to allow_value(rand(50)).for(:first_name) }
  end
end
