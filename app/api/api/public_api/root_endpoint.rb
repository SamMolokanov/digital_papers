module Api
  module PublicApi
    class RootEndpoint < Grape::API
      mount Users::RootEndpoint => "users"
    end
  end
end
