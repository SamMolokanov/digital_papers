module Api
  module AuthorizedApi
    class RootEndpoint < Grape::API
      Grape::Middleware::Auth::Strategies.add(
        :digital_papers_token,
        Api::Authentication::Middleware
      )

      auth :digital_papers_token

      helpers AuthenticationHelper

      mount Documents::RootEndpoint => "documents"
      mount Users::RootEndpoint => "users"
    end
  end
end
