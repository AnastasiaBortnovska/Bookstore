# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  after_action :set_online

  def destroy
    ConnectRedisService.delete_data("user:#{current_user.id}")
    super
  end

  private

  def set_online
    ConnectRedisService.set_data("user:#{current_user.id}", current_user.id, { ex: 10 * 60 }) if current_user
  end
end
