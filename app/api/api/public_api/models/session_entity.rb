module Api
  module PublicApi
    module Models
      class SessionEntity < Grape::Entity
        expose :token, documentation: { type: "string", desc: "Token for authentication", required: true }
      end
    end
  end
end
