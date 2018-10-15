require "grape-swagger"

module Api
  class RootEndpoint < Grape::API
    version "v1", using: :header, vendor: "digital_papers"

    content_type :json, "application/json"
    default_format :json

    rescue_from Authentication::Error do |_e|
      error!("Unauthorized", 401)
    end

    rescue_from ActiveRecord::RecordNotFound do |_e|
      error!("404 Not found", 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      error!(exception.record.errors.as_json, 422)
    end

    mount Status::ShowEndpoint
    mount AuthorizedApi::RootEndpoint => "authorized"

    mount PublicApi::RootEndpoint => "public"

    add_swagger_documentation
  end
end
