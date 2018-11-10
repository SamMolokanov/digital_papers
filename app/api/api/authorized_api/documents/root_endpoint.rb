module Api
  module AuthorizedApi
    module Documents
      class RootEndpoint < Grape::API
        mount Documents::CreateEndpoint
        mount Documents::IndexEndpoint
        mount Documents::DeleteEndpoint
      end
    end
  end
end
