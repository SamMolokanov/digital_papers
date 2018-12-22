require "rails_helper"

describe User::SessionsType do
  describe "#deserialize" do
    let(:session1) { Auth::Session.new(token: "a") }
    let(:session2) { Auth::Session.new(token: "b") }

    let(:raw_sessions) do
      [
        { token: "a" },
        { token: "b" },
      ].to_json
    end

    subject { described_class.new.deserialize(raw_sessions) }

    it { is_expected.to eq Auth::Sessions.new([session1, session2]) }
  end

  describe "#serialize" do
    let(:session1) { Auth::Session.new(token: "a") }
    let(:session2) { Auth::Session.new(token: "b") }

    let(:auth_sessions) { Auth::Sessions.new([session1, session2]) }

    subject { described_class.new.serialize(auth_sessions) }

    it "serializes sessions as JSON with token" do
      is_expected.to eq [
        { token: "a" },
        { token: "b" },
      ].to_json
    end
  end
end
