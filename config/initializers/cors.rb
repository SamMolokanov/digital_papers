# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:8080"
    resource "*",
      headers: :any,
      methods: %i(get post put patch delete options head),
      expose: ["access-token", "expiry", "token-type", "uid", "client"]
  end
end
