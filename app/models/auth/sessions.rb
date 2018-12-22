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
      @sessions.delete_if(&finder(session.digest))
    end

    def find(digest)
      @sessions.find(&finder(digest))
    end

    def <<(session)
      @sessions << session
    end

    def ==(that)
      sessions.map(&:to_h) == that.sessions.map(&:to_h)
    end

    private

    def finder(digest)
      proc { |session| session.digest == digest }
    end
  end
end
