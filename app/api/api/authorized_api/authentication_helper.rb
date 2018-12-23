module Api
  module AuthorizedApi
    module AuthenticationHelper
      def current_user
        @current_user ||= env[Api::Authentication::Middleware::CURRENT_AUTH_SESSION].user
      end

      def current_token
        @current_token ||= env[Api::Authentication::Middleware::CURRENT_AUTH_SESSION].token
      end
    end
  end
end
