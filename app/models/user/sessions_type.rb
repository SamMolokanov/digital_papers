class User
  class SessionsType < ActiveRecord::Type::Value
    include ActiveModel::Type::Helpers::Mutable

    def type
      :user_auth_sessions
    end

    def deserialize(raw_sessions)
      sessions = ::ActiveSupport::JSON.decode(raw_sessions) rescue []
      Auth::Sessions.new (sessions).map { |s| Auth::Session.new(pepper: nil, token: s["token"]) }
    end

    def serialize(sessions)
      ::ActiveSupport::JSON.encode(sessions.sessions.map(&:to_h))
    end
  end
end
