module Api
  module AuthorizedApi
    module AuthenticationHelper
      def current_user
        @current_user ||= env[Api::Authentication::Middleware::CURRENT_USER]
      end

      def current_token
        @current_token ||= env[Api::Authentication::Middleware::CURRENT_TOKEN]
      end
    end
  end
end
