module Api
  module AuthorizedApi
    module Users
      module Tokens
        class DeleteEndpoint < Grape::API
          desc "Deletes the Token",
            detail: "Deletes the provided auth token",
            headers: { "Authorization" => { description: "Token to be deleted", type: "string" } },
            failure: [{ code: 401, message: "Unauthorized" }],
            nickname: "delete_token",
            named: "delete_token"

          delete do
            Api::Authentication::Session.new(current_token).destroy!

            return_no_content
          end
        end
      end
    end
  end
end
