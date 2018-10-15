module Api
  module Authentication
    module Session
      module_function

      def create(email, password)
        user = User.find_by(email: email)
        raise Error unless user && user.authenticate(password)

        session = Auth::Session.new(pepper: user.password_digest)
        user.sessions << session
        user.save!
        session
      end

      def destroy(token)
        user = current_user(token)
        raise Error unless user

        session = Auth::Session.new(pepper: user.password_digest, token: token)

        raise Error unless session.valid?

        user.sessions.invalidate(session)
        user.save!
      end

      def current_user(token)
        User.find_by_session(Auth::Session.new(token: token))
      end
    end
  end
end
