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
          documents = current_user.documents.order(created_at: :desc)

          present documents, with: Models::DocumentEntity
        end
      end
    end
  end
end
