module Api
  module PublicApi
    module Users
      class CreateEndpoint < Grape::API
        desc "Creates a new User",
          detail: "Returns the created user representation",
          success: { code: 201, model: Models::UserEntity },
          failure: [ { code: 422, message: "Invalid parameters" } ],
          produces: ["application/json"],
          consumes: ["multipart/form-data"],
          nickname: "create_user",
          named: "create_user"

        params do
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
          optional :name, type: String
        end

        post do
          present User.create!(declared(params)), with: Models::UserEntity
        end
      end
    end
  end
end
