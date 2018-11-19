module Api
  module AuthorizedApi
    module Models
      class AttachmentEntity < Grape::Entity
        include Rails.application.routes.url_helpers

        expose :key, documentation: { type: "string", desc: "Key of the attachment", required: true }
        expose :filename, documentation: { type: "string", desc: "Name the attachment" }
        expose :url, documentation: { type: "string", desc: "URL to the attachment" }
        expose :content_type, documentation: { type: "string", desc: "Content Type of the attachment" }

        private

        def url
          url_for(object)
        end
      end
    end
  end
end
