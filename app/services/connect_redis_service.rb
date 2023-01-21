# frozen_string_literal: true

class ConnectRedisService
  def self.get_data(key)
    JSON.parse(connect.get(key))
  rescue TypeError
    []
  end

  def self.set_data(key, value, **options)
    connect.set(key, value, options)
  end

  def self.delete_data(key)
    connect.del(key)
  end

  def self.connect
    @connect ||= REDIS_INSTANCE
  end
end
