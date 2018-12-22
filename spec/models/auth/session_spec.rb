require "rails_helper"

describe Auth::Session do
  describe "#token" do
    context "when uses token provider" do
      let(:token_provider) { double generate: "foo_token" }

      subject(:token) { described_class.new(token_provider: token_provider).token }

      it { is_expected.to eq "foo_token" }
    end

    context "when uses the given token" do
      subject(:token) { described_class.new(token: "bar_token").token }

      it { is_expected.to eq "bar_token" }
    end
  end

  describe "#valid?" do
    context "when is valid" do
      let(:token_provider) { double valid?: true }

      subject(:valid) { described_class.new(token: "foo_token", token_provider: token_provider).valid? }

      it { is_expected.to be_truthy }
    end

    context "when is invalid" do
      let(:token_provider) { double valid?: false }

      subject(:valid) { described_class.new(token: "foo_token", token_provider: token_provider).valid? }

      it { is_expected.to be_falsey }
    end
  end
end
