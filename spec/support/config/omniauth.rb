# frozen_string_literal: true

module OmniAuthTestHelper
  def stub_facebook_omniauth(uid: '', email: '')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: uid,
      info: { email: email }
    )
  end
end

RSpec.configure do |config|
  config.include(OmniAuthTestHelper, type: :controller)
  config.include(OmniAuthTestHelper, type: :model)
  config.include(OmniAuthTestHelper, type: :feature)
end
