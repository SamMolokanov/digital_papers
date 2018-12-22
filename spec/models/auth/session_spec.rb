require "rails_helper"

describe Auth::Session do
  describe "#token" do
    subject(:token) { described_class.new(token: "foo_token").token }

    it { is_expected.to eq "foo_token" }
  end
end
