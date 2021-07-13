# frozen_string_literal: true

class AuthenticateUsersController < ApplicationController
  def create
    user = User.create(user_params)
    return failure(I18n.t('message.error.user.authenticate_new_user')) unless user.save

    user.send_reset_password_instructions
    success(user, current_order)
  end

  def show
    user = User.find_by(email: user_params[:email])
    if user.present? && user.valid_password?(user_params[:password])
      success(user, current_order)
    else
      failure(I18n.t('message.error.user.authenticate_user'))
    end
  end

  private

  def success(user, order)
    sign_in(user)
    order.update(user: user)
    redirect_to checkout_path(:addresses)
  end

  def failure(message)
    flash[:danger] = message
    redirect_to request.referer || root_path
  end

  def user_params
    unless params[:user][:password]
      return params.require(:user).permit(:email).merge(password: Devise.friendly_token[0, 20])
    end

    params.require(:user).permit(:email, :password)
  end
end
