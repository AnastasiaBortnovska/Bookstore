# frozen_string_literal: true

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.not_to allow_value(FFaker::Name.first_name).for(:password) }
    it { is_expected.to allow_value(FFaker::String.from_regexp(User::PASSWORD_FORMAT)).for(:password) }
    it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_one(:billing_address).dependent(:destroy) }
    it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  end

  describe '.from_omniauth' do
    before { described_class.from_omniauth(auth) }

    context 'when user created' do
      let(:auth) { stub_facebook_omniauth(uid: rand(5), email: FFaker::Internet.email) }

      it { expect(described_class.last.email).to eq(auth.info.email) }
    end

    context 'when user found' do
      let(:auth) { create(:user, :with_provider, :with_uid) }

      it { expect(described_class.last.email).to eq(auth.email) }
    end
  end
end
