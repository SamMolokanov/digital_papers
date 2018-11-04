module Api
  module AuthorizedApi
    module Models
      class DocumentEntity < Grape::Entity
        expose :id, documentation: { type: "string", desc: "Id of the document", required: true }
        expose :name, documentation: { type: "string", desc: "Name the document" }
      end
    end
  end
end
