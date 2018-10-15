GrapeSwaggerRails.options.url = "/api/swagger_doc"

GrapeSwaggerRails.options.api_key_name = "Authorization"
GrapeSwaggerRails.options.api_key_type = "header"

GrapeSwaggerRails.options.before_action do
  if Rails.env.development?
    token = User.last.create_new_auth_token

    GrapeSwaggerRails.options.headers.merge!(token)
  end

  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
