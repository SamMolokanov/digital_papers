require "rails_helper"

describe "DELETE /api/authorized/users/sessions" do
  let(:path) { "/api/authorized/users/sessions" }

  context "when valid params" do
    let(:user) { create :authorized_user }
    let(:session) { user.sessions.first }

    before do
      2.times { user.sessions << Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest)) }
      user.save
    end

    context "when performs request" do
      subject(:perform_request) do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer #{session.token}" },
        )
      end

      it "deletes the session from the user" do
        expect { subject }.to change { user.reload.sessions.count }.by(-1)
      end

      it { subject; expect(response).to have_http_status :no_content }
    end
  end

  context "when invalid token is given" do
    let(:user) { create :authorized_user }

    context "when performs request" do
      subject(:perform_request) do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer fooobar" },
        )
      end

      it "does not delete the session" do
        expect { subject }.not_to change { user.reload.sessions.count }
      end

      it { subject; expect(response).to have_http_status(:unauthorized) }
    end
  end
end
