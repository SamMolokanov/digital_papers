module Api
  module Authentication
    class Middleware
      CURRENT_USER = "CURRENT_USER"
      HTTP_AUTHORIZATION = "HTTP_AUTHORIZATION"

      attr_reader :app

      def initialize(app, *options)
        @app = app
        @options = options
      end

      def call(env)
        dup._call(env)
      end

      def _call(env)
        @env = env

        raise Error unless token.present? && current_user.present?
        env[CURRENT_USER] = current_user

        app.call(env)
      end

      private

      def token
        @env.fetch(HTTP_AUTHORIZATION, "").slice(7..-1)
      end

      def current_user
        @current_user ||= Authentication::Session.find_user(token)
      end
    end
  end
end
