require "rails_helper"

describe "/api/status", type: :request do
  describe "GET #show" do
    let(:path) { "/api/status" }
    let(:token) { User.create!(email: "foo@bar.com", password: "asdf1234", password_confirmation: "asdf1234").create_new_auth_token }

    before do
      get(
        path,
        headers: {
          "ACCEPT" => "application/json",
          "Authorization" => token,
        },
      )
    end

    it "responds with success" do
      expect(response).to have_http_status :ok
    end
  end
end
