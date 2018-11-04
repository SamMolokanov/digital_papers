require "rails_helper"

describe "POST /api/public/users/sessions" do
  let(:path) { "/api/public/users/sessions" }

  context "when valid params" do
    let(:password) { "asdfg1234" }
    let(:user) { create :user, password: password, password_confirmation: password }

    let(:params) { { email: user.email, password: password } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "creates a new session for the user" do
        expect { subject }.to change { user.reload.sessions.count }.by(1)
      end
    end

    context "when returns response" do
      before do
        allow(Auth::TokenProvider).to receive(:generate).and_return("foo")

        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it { expect(response).to have_http_status :created }
      it { expect(response).to match_json_schema("public_api/sessions/session") }

      it "renders user as json" do
        expect(JSON.parse(response.body)).to eq("token" => "foo")
      end
    end
  end

  context "when invalid email is given" do
    let(:password) { "asdfg1234" }
    let(:user) { create :user, password: password, password_confirmation: password }

    let(:params) { { email: "foo-#{user.email}", password: password } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "does not create a new session" do
        expect { subject }.not_to change { user.reload.sessions.count }
      end
    end

    context "when returns response" do
      before do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "returns the unauthorized error messages" do
        expect(JSON.parse(response.body)).to eq("error" => "Unauthorized")
      end
    end
  end

  context "when password is wrong" do
    let(:password) { "asdfg1234" }
    let(:user) { create :user, password: password, password_confirmation: password }

    let(:params) { { email: user.email, password: "asd#{password}" } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "does not create a new sessions" do
        expect { subject }.not_to change { user.reload.sessions.count }
      end
    end

    context "when returns response" do
      before do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "returns the unauthorized error messages" do
        expect(JSON.parse(response.body)).to eq("error" => "Unauthorized")
      end
    end
  end
end
