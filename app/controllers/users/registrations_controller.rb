# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    user_params[:email].present? ? update_email : update_password
  end

  def destroy
    current_user.destroy ? success_crud(t('message.success.user.destroy')) : unsuccess
  end

  private

  def update_email
    current_user.update_without_password(user_params) ? success_crud(t('message.success.user.update_email')) : unsuccess
  end

  def update_password
    current_user.update_with_password(user_params) ? success_crud(t('message.success.user.update_password')) : unsuccess
  end

  def success_crud(message)
    flash[:success] = message
    redirect_to root_path and return
  end

  def unsuccess
    flash[:danger] = current_user.errors.full_messages.to_sentence
    redirect_to edit_user_registration_path(current_user)
  end

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end
end
