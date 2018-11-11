module Api
  module AuthorizedApi
    module AuthenticationHelper
      def current_user
        @current_user ||= env[Api::Authentication::Middleware::CURRENT_USER]
      end
    end
  end
end
