module Api
  module PublicApi
    module Users
      module Sessions
        class RootEndpoint < Grape::API
          mount Sessions::CreateEndpoint => "/"
        end
      end
    end
  end
end
