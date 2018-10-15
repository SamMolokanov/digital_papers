module Api
  module AuthorizedApi
    module Users
      class RootEndpoint < Grape::API
        mount Sessions::RootEndpoint => "/sessions"
      end
    end
  end
end
