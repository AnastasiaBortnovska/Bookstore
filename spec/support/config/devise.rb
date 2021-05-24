# frozen_string_literal: true

require 'devise'

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:facebook] = {
  'info' => {
    'name' => 'Mario Brothers',
    'image' => '',
    'email' => 'dpsk@email.ru'
  },
  'uid' => '123545',
  'provider' => 'facebook',
  'credentials' => { 'token' => 'token' }
}

OmniAuth.config.add_mock(:facebook, OmniAuth.config.mock_auth[:facebook])

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
end
