require "rails_helper"

describe Auth::TokenProvider do
  describe "#valid?" do
    context "when token was generated with the same pepper" do
      let(:pepper) { "foobar" }
      let(:token) { described_class.new(pepper).generate }

      subject { described_class.new(pepper).valid?(token) }

      it { is_expected.to be_truthy }
    end

    context "when token was generated with other pepper" do
      let(:token) { described_class.new("pepper_a").generate }

      subject { described_class.new("pepper_b").valid?(token) }

      it { is_expected.to be_falsey }
    end

    context "when token is random" do
      let(:pepper) { "foobar" }
      let(:token) { "whatever_token_here" }

      subject { described_class.new(pepper).valid?(token) }

      it { is_expected.to be_falsey }
    end

    context "when token is nil" do
      let(:pepper) { "foobar" }
      let(:token) { nil }

      subject { described_class.new(pepper).valid?(token) }

      it { is_expected.to be_falsey }
    end
  end
end
