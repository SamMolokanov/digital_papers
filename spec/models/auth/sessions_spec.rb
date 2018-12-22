require "rails_helper"

describe Auth::Sessions do
  describe "#<<" do
    let(:session) { Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }
    let(:sessions) { described_class.new }

    subject { sessions << session }

    it { expect { subject }.to change { sessions.count }.from(0).to(1)  }
  end

  describe "#invalidate" do
    let(:session1) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }
    let(:session2) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }

    let(:sessions) { described_class.new([session1, session2]) }

    subject { sessions.invalidate(session1) }

    it { expect { subject }.to change { sessions.count }.from(2).to(1)  }
  end

  describe "#delete_all" do
    let(:session1) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }
    let(:session2) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }

    let(:sessions) { described_class.new([session1, session2]) }

    subject { sessions.delete_all }

    it { expect { subject }.to change { sessions.count }.from(2).to(0)  }
  end

  describe "#find" do
    let(:session1) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }
    let(:session2) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }

    let(:sessions) { described_class.new([session1, session2]) }

    subject { sessions.find(session2.token) }

    it { is_expected.to eq session2 }
  end

  describe "#==" do
    let(:session1) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }
    let(:session2) {  Auth::Session.new(token_provider: Auth::TokenProvider.new("pepper")) }

    subject { described_class.new([session1, session2]) == described_class.new([session1, session2]) }

    it { is_expected.to be_truthy }
  end
end
