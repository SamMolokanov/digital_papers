module Api
  module PublicApi
    module Users
      class RootEndpoint < Grape::API
        mount CreateEndpoint

        mount Sessions::RootEndpoint => "/sessions"
      end
    end
  end
end
