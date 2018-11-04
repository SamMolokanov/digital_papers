module Api
  module AuthorizedApi
    module Documents
      class IndexEndpoint < Grape::API
        desc "List of a Documents for the user",
          detail: "Returns the collection of documents",
          headers: { "Authorization" => { description: "Authorization Token", type: "string" } },
          success: { code: 200, model: Models::DocumentEntity },
          failure: [{ code: 401, message: "Unauthorized" }],
          produces: ["application/json"],
          consumes: ["application/json"],
          nickname: "documents",
          named: "documents"

        get do
          # TODO: Move User authorization somewhere
          user = Authentication::Session.find_user(headers["Authorization"].slice(7..-1))
          raise Authentication::Error unless user

          documents = user.documents.order(created_at: :desc)

          present documents, with: Models::DocumentEntity
        end
      end
    end
  end
end
