module Api
  module PublicApi
    module Users
      class RootEndpoint < Grape::API
        mount CreateEndpoint

        mount Tokens::RootEndpoint => "/tokens"
      end
    end
  end
end
