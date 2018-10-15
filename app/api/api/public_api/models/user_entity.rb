module Api
  module PublicApi
    module Models
      class UserEntity < Grape::Entity
        expose :id, documentation: { type: "string", desc: "Id of the user", required: true }
        expose :email, documentation: { type: "string", desc: "Email of the user", required: true  }
        expose :name, documentation: { type: "string", desc: "Name the user" }
      end
    end
  end
end
