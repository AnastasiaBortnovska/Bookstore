# frozen_string_literal: true

RSpec.describe Address do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    %i[first_name last_name country city address zip phone].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
