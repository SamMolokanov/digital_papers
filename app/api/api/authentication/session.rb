module Api
  module Authentication
    module Session
      module_function

      def create(email, password)
        user = User.find_by(email: email)
        raise Error unless user && user.authenticate(password)

        session = Auth::Session.new(token: token_provider(user).generate)
        user.sessions << session
        user.save!
        session
      end

      def destroy(token)
        user = find_user(token)

        raise Error unless user
        raise Error unless token_provider(user).valid?(token)

        user.sessions.invalidate(token)
        user.save!
      end

      def find_user(token)
        User.find_by_token(token)
      end

      def token_provider(user)
        Auth::TokenProvider.new(user.password_digest)
      end
    end
  end
end
