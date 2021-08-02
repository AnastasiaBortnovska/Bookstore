# frozen_string_literal: true

RSpec.describe Address do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
  end

  describe 'validations' do
    %i[first_name last_name country city address zip phone].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[first_name last_name country city address].each do |field|
      it { is_expected.to validate_length_of(field).is_at_most(Address::MAXIMUM_TEXT_LENGTH) }
    end

    it { is_expected.to validate_length_of(:zip).is_at_most(Address::MAXIMUM_ZIP_LENGTH) }
    it { is_expected.to validate_length_of(:phone).is_at_most(Address::MAXIMUM_PHONE_LENGTH) }

    %i[first_name last_name city].each do |field|
      it { is_expected.to allow_value(FFaker::String.from_regexp(Address::TEXT_FORMAT)).for(field) }
    end

    it { is_expected.to allow_value(FFaker::String.from_regexp(Address::ZIP_FORMAT)).for(:zip) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(Address::COUNTRY_FORMAT)).for(:country) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(Address::ADDRESS_FORMAT)).for(:address) }
  end
end
