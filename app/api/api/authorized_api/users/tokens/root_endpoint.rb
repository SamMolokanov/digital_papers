module Api
  module AuthorizedApi
    module Users
      module Tokens
        class RootEndpoint < Grape::API
          mount Tokens::DeleteEndpoint => "/"
        end
      end
    end
  end
end
