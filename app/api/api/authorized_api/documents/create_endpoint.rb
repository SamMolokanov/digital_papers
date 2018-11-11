module Api
  module AuthorizedApi
    module Documents
      class CreateEndpoint < Grape::API
        helpers AuthenticationHelper

        desc "Creates a new Document for the user",
          detail: "Returns the created document representation",
          headers: { "Authorization" => { description: "Authorization Token", type: "string" } },
          success: { code: 201, model: Models::DocumentEntity },
          failure: [{ code: 401, message: "Unauthorized" }, { code: 422, message: "Invalid parameters" }],
          produces: ["application/json"],
          consumes: ["multipart/form-data"],
          nickname: "create_document",
          named: "create_document"

        params do
          requires :file, type: File
          optional :name, type: String, desc: "Name of the document"
        end

        post do
          file = declared(params)["file"]

          document_params = {
            name: declared(params)["name"] || file["filename"],
            file: {
              content_type: file["type"],
              filename: file["filename"],
              io: file["tempfile"],
            },
          }

          document = current_user.documents.create!(document_params)

          present document, with: Models::DocumentEntity
        end
      end
    end
  end
end
