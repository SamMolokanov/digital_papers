module Api
  module AuthorizedApi
    module Documents
      class DeleteEndpoint < Grape::API
        desc "Deletes the Document",
          detail: "Deletes the Document",
          headers: { "Authorization" => { description: "Authorization Token", type: "string" } },
          success: { code: 204 },
          failure: [{ code: 401, message: "Unauthorized" }, { code: 404, message: "Not found" }],
          produces: ["application/json"],
          consumes: ["multipart/form-data"],
          nickname: "delete_document",
          named: "delete_document"

        params do
          requires :id, type: String, desc: "Id of the document"
        end

        delete ":id" do
          document = current_user.documents.find(declared(params)["id"])
          document.destroy!
          return_no_content
        end
      end
    end
  end
end
