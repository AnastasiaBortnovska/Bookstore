# frozen_string_literal: true

RSpec.describe AddressForm, type: :model do
  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:first_name).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:country).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:city).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:address).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:zip).is_at_most(AddressForm::LENGTH[:zip]) }
    it { is_expected.to validate_length_of(:phone).is_at_most(AddressForm::LENGTH[:phone]) }
  end

  describe 'valid inputs' do
    let(:valid_text_input) { FFaker::Name.first_name }
    let(:valid_zip_input) { FFaker::AddressUS.zip_code }
    let(:valid_phone_input) { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/\s/, '').delete('-') }

    it { is_expected.to allow_value(valid_text_input).for(:first_name) }
    it { is_expected.to allow_value(valid_text_input).for(:last_name) }
    it { is_expected.to allow_value(valid_text_input).for(:country) }
    it { is_expected.to allow_value(valid_text_input).for(:city) }
    it { is_expected.to allow_value(valid_text_input).for(:address) }
    it { is_expected.to allow_value(valid_zip_input).for(:zip) }
    it { is_expected.to allow_value(valid_phone_input).for(:phone) }
  end

  describe 'invalid inputs' do
    let(:invalid_text_input) { FFaker::AddressUS.zip_code }
    let(:invalid_address_input) { nil }
    let(:invalid_zip_input) { FFaker::Name.first_name }
    let(:invalid_phone_input) { FFaker::Name.first_name }

    it { is_expected.not_to allow_value(invalid_text_input).for(:first_name) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:last_name) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:country) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:city) }
    it { is_expected.not_to allow_value(invalid_address_input).for(:address) }
    it { is_expected.not_to allow_value(invalid_zip_input).for(:zip) }
    it { is_expected.not_to allow_value(invalid_phone_input).for(:phone) }
  end

  describe '#save' do
    subject(:address_form) { described_class.new(params) }

    let(:user) { create(:user) }

    before do
      address_form.save(user)
    end

    context 'when success' do
      let(:params) { attributes_for(:address, :billing) }

      it { expect(user.addresses.billing.first.first_name).to eq params[:first_name] }
    end

    context 'when fail' do
      let(:params) { attributes_for(:address, :billing, first_name: rand(150)) }

      it { expect(user.addresses.billing.first).to eq nil }
    end
  end
end
