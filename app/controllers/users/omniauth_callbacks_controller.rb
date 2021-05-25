# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    return failure unless @user.persisted?

    success
  end

  private

  def failure
    session['devise.facebook_data'] = request.env['omniauth.auth']
    set_flash_message(:alert, :failure, kind: I18n.t('devise.omniauth_callbacks.facebook'))
    redirect_to new_user_registration_url
  end

  def success
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: I18n.t('devise.omniauth_callbacks.facebook')) if is_navigational_format?
  end
end
