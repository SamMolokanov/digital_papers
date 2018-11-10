module Api
  module AuthorizedApi
    module Users
      module Sessions
        class DeleteEndpoint < Grape::API
          desc "Deletes the Token",
            detail: "Deletes the provided auth token",
            headers: { "Authorization" => { description: "Token to be deleted", type: "string" } },
            failure: [{ code: 401, message: "Unauthorized" }],
            nickname: "delete_token",
            named: "delete_token"

          delete do
            # TODO: Move session extraction to concern
            Api::Authentication::Session.destroy(headers["Authorization"].slice(7..-1))

            return_no_content
          end
        end
      end
    end
  end
end
