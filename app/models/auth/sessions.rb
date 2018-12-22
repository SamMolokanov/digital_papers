module Auth
  class Sessions
    attr_reader :sessions

    include Enumerable

    delegate :each, :<<, to: :sessions

    def initialize(sessions = [])
      @sessions = sessions
    end

    def delete_all
      @sessions = []
    end

    def invalidate(session)
      @sessions.delete_if(&finder(session.token))
    end

    def find(token)
      @sessions.find(&finder(token))
    end

    def <<(session)
      @sessions << session
    end

    def ==(that)
      sessions.map(&:to_h) == that.sessions.map(&:to_h)
    end

    private

    def finder(token)
      proc { |session| session.token == token }
    end
  end
end
