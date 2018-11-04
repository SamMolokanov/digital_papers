module Api
  module AuthorizedApi
    class RootEndpoint < Grape::API
      mount Users::RootEndpoint => "users"
    end
  end
end
