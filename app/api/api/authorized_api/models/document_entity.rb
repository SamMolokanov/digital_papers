module Api
  module AuthorizedApi
    module Models
      class DocumentEntity < Grape::Entity
        expose :id, documentation: { type: "string", desc: "Id of the document", required: true }
        expose :name, documentation: { type: "string", desc: "Name the document" }
        expose :file,
          if: lambda { |doc, _options| doc.file.attached? },
          using: AttachmentEntity,
          documentation: { type: "AttachmentEntity", desc: "Attached file" }
      end
    end
  end
end
