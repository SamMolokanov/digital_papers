require "rails_helper"

describe User::SessionsType do
  describe "#deserialize" do
    let(:session1) { Auth::Session.new(token: "aaa") }
    let(:session2) { Auth::Session.new(token: "bbb") }

    let(:raw_sessions) do
      [
        { token: session1.token },
        { token: session2.token },
      ].to_json
    end

    subject { described_class.new.deserialize raw_sessions }

    it "restores sessions without pepper" do
      is_expected.to eq Auth::Sessions.new([Auth::Session.new(token: "aaa"), Auth::Session.new(token: "bbb")])
    end
  end

  describe "#serialize" do
    let(:session1) { Auth::Session.new(token_provider: Auth::TokenProvider.new("a")) }
    let(:session2) { Auth::Session.new(token_provider: Auth::TokenProvider.new("b")) }

    let(:auth_sessions) { Auth::Sessions.new([session1, session2]) }

    subject { described_class.new.serialize auth_sessions }

    it "serializes sessions as JSON" do
      is_expected.to eq [
        { token: session1.token },
        { token: session2.token },
      ].to_json
    end
  end
end
