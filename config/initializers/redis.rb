REDIS = ENV["REDIS_URL"] ? Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }) : nil
REDIS_INSTANCE = REDIS || Redis.new(url: 'redis://127.0.0.1:6379')
