module Api
  module AuthorizedApi
    class RootEndpoint < Grape::API
      mount Documents::RootEndpoint => "documents"
      mount Users::RootEndpoint => "users"
    end
  end
end
