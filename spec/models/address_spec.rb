# frozen_string_literal: true

RSpec.describe Address do
  describe 'associations' do
    it { is_expected.to belong_to(:addressable) }
  end

  describe 'address_type enum value' do
    it { expect(described_class.address_types[:billing]).to eq 0 }
    it { expect(described_class.address_types[:shipping]).to eq 1 }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:phone) }
  end
end
