# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate :id

  def online?
    ConnectRedisService.get_data("user:#{id}").present? ? I18n.t('users.index.online') : I18n.t('users.index.offline')
  end
end
