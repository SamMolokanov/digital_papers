module Api
  module AuthorizedApi
    module Users
      module Sessions
        class RootEndpoint < Grape::API
          mount Sessions::DeleteEndpoint => "/"
        end
      end
    end
  end
end
