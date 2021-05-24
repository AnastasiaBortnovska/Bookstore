# frozen_string_literal: true

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.not_to allow_value(FFaker::Name.first_name).for(:password) }
    it { is_expected.to allow_value(FFaker::Internet.password).for(:password) }
    it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
  end

  describe 'from_omniauth' do
    let(:auth) { OmniAuth.config.mock_auth[:facebook] }
    let(:user) { described_class.from_omniauth(auth) }

    it 'returns or cteate user' do
      expect(user.email).to eq(auth.info.email)
    end
  end
end
