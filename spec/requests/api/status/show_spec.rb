require "rails_helper"

describe "/api/status" do
  describe "GET /api/status" do
    let(:path) { "/api/status" }

    before { get path, headers: { "ACCEPT" => "application/json" } }

    it { expect(response).to have_http_status :ok }
  end
end
