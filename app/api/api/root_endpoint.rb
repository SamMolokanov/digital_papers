require "grape-swagger"

module Api
  class RootEndpoint < Grape::API
    version "v1", using: :header, vendor: "digital_papers"

    content_type :json, "application/json"
    default_format :json

    # rescue_from GrapeDeviseTokenAuth::Unauthorized do |_e|
    #   error!("Unauthorized", 401)
    # end

    mount Status::ShowEndpoint

    add_swagger_documentation
  end
end
