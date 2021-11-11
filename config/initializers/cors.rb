Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '10.10.0.25'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
