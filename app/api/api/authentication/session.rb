module Api
  module Authentication
    module Session
      module_function

      def create(email, password)
        user = User.find_by(email: email)
        raise Error unless user && user.authenticate(password)

        session = Auth::Session.new(token_provider: token_provider(user))
        user.sessions << session
        user.save!
        session
      end

      def destroy(token)
        user = find_user(token)
        raise Error unless user

        session = Auth::Session.new(token: token, token_provider: token_provider(user))

        raise Error unless session.valid?

        user.sessions.invalidate(session)
        user.save!
      end

      def find_user(token)
        User.find_by_session(Auth::Session.new(token: token))
      end

      def token_provider(user)
        Auth::TokenProvider.new(user.password_digest)
      end
    end
  end
end
