require "rails_helper"

describe "GET /api/authorized/documents" do
  let(:path) { "/api/authorized/documents" }

  context "when returns response" do
    let(:user) { create :authorized_user }
    let(:auth_token) { "Bearer #{user.sessions.first.token}" }

    let!(:document1) { create :document, user: user, name: "foo", created_at: DateTime.parse("22-12-2015") }
    let!(:document2) { create :document, user: user, name: "bar", created_at: DateTime.parse("12-11-2017") }

    before do
      get(
        path,
        headers: { "ACCEPT" => "application/json", "Authorization" => auth_token },
      )
    end

    it { expect(response).to have_http_status :success }
    it { expect(response).to match_json_schema("authorized_api/documents") }

    let(:expected_json) do
      [
        { "id" => document2.id, name: "bar" },
        { "id" => document1.id, name: "foo" },
      ].as_json
    end

    it "renders user's documents as json ordered by creation time" do
      expect(JSON.parse(response.body)).to eq expected_json
    end
  end

  context "when invalid token is given" do
    before do
      get(
        path,
        headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer fooobar" },
      )
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
