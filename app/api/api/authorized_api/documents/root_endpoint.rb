module Api
  module AuthorizedApi
    module Documents
      class RootEndpoint < Grape::API
        mount Documents::CreateEndpoint
      end
    end
  end
end
