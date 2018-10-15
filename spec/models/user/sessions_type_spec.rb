require "rails_helper"

describe User::SessionsType do
  describe "#deserialize" do
    let(:session1) { Auth::Session.new(token: "aaa") }
    let(:session2) { Auth::Session.new(token: "bbb") }

    let(:raw_sessions) do
      [
        { digest: session1.digest, token: session1.token },
        { digest: session2.digest, token: session2.token },
      ].to_json
    end

    subject { described_class.new.deserialize raw_sessions }

    it "restores sessions without pepper" do
      is_expected.to eq Auth::Sessions.new([Auth::Session.new(token: "aaa"), Auth::Session.new(token: "bbb")])
    end
  end

  describe "#serialize" do
    let(:session1) { Auth::Session.new(pepper: "a") }
    let(:session2) { Auth::Session.new(pepper: "b") }

    let(:auth_sessions) { Auth::Sessions.new([session1, session2]) }

    subject { described_class.new.serialize auth_sessions }

    it "serializes sessions as JSON" do
      is_expected.to eq [
        { digest: session1.digest, token: session1.token },
        { digest: session2.digest, token: session2.token },
      ].to_json
    end
  end
end
