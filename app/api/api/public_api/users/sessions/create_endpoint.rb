module Api
  module PublicApi
    module Users
      module Sessions
        class CreateEndpoint < Grape::API
          desc "Creates a new Token",
            detail: "Returns new auth token",
            success: { code: 201, model: Models::SessionEntity },
            failure: [{ code: 401, message: "Unauthorized" }],
            produces: ["application/json"],
            consumes: ["multipart/form-data"],
            nickname: "create_token",
            named: "create_token"

          params do
            requires :email, type: String
            requires :password, type: String
          end

          post do
            session = Api::Authentication::Session.create(
              declared(params)[:email].downcase,
              declared(params)[:password],
            )

            present session, with: Models::SessionEntity
          end
        end
      end
    end
  end
end
