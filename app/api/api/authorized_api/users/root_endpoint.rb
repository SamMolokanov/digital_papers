module Api
  module AuthorizedApi
    module Users
      class RootEndpoint < Grape::API
        mount Tokens::RootEndpoint => "/tokens"
      end
    end
  end
end
