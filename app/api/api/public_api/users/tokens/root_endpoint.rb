module Api
  module PublicApi
    module Users
      module Tokens
        class RootEndpoint < Grape::API
          mount Tokens::CreateEndpoint => "/"
        end
      end
    end
  end
end
