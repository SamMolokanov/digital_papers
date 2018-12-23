module Api
  module Authentication
    class Session
      attr_reader :token

      # TODO: refactor this method
      def self.create!(email, password)
        user = User.find_by(email: email)
        raise Error unless user && user.authenticate(password)

        token = Auth::TokenProvider.new(user.password_digest).generate
        session = Auth::Session.new(token: token)
        user.sessions << session
        user.save!

        new(session.token)
      end

      def initialize(token)
        @token = token
      end

      def user
        @user ||= User.find_by_token(token)
      end

      def destroy!
        raise Error unless user
        raise Error unless token_provider.valid?(token)

        user.sessions.invalidate(token)
        user.save!
      end

      def token_provider
        Auth::TokenProvider.new(user.password_digest)
      end
    end
  end
end
