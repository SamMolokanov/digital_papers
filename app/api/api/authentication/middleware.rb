module Api
  module Authentication
    class Middleware
      CURRENT_AUTH_SESSION = "CURRENT_AUTH_SESSION"
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

        raise Error unless token.present? && auth_session.user.present?

        env[CURRENT_AUTH_SESSION] = auth_session

        app.call(env)
      end

      private

      def auth_session
        @auth_session ||= Authentication::Session.new(token)
      end

      def token
        return @token if defined? @token

        scheme, raw_token = @env.fetch(HTTP_AUTHORIZATION, "").split(" ")

        return nil if scheme != "Bearer"
        @token = raw_token
      end
    end
  end
end
