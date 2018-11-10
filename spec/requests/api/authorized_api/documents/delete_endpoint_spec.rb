require "rails_helper"

describe "DELETE /api/authorized/documents/:id" do
  context "when valid id" do
    let(:user) { create :authorized_user }
    let(:auth_token) { "Bearer #{user.sessions.first.token}" }

    let!(:document) { create :document, user: user }
    let(:path) { "/api/authorized/documents/#{document.id}" }

    context "when performs request" do
      subject(:perform_request) do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => auth_token },
        )
      end

      it "deletes the document for the user" do
        expect { subject }.to change { user.reload.documents.count }.by(-1)
      end

      it "deletes the document" do
        expect { subject }.to change { Document.where(id: document).exists? }.from(true).to(false)
      end
    end

    context "when return response" do
      before do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => auth_token },
        )
      end

      subject { response }

      it { is_expected.to have_http_status :no_content }
    end
  end

  context "when id is not associated with user" do
    let(:user) { create :authorized_user }
    let(:auth_token) { "Bearer #{user.sessions.first.token}" }

    let(:document) { create :document }
    let(:path) { "/api/authorized/documents/#{document.id}" }

    context "when performs request" do
      subject(:perform_request) do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => auth_token },
        )
      end

      it "does not delete the document" do
        expect { subject }.not_to change { document.reload.persisted? }
      end
    end

    context "when return response" do
      before do
        delete(
          path,
          headers: { "ACCEPT" => "application/json", "Authorization" => auth_token },
        )
      end

      subject { response }

      it { is_expected.to have_http_status :not_found }
    end
  end

  context "when invalid token is given" do
    before do
      delete(
        "/api/authorized/documents/123",
        headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer FooBar" },
      )
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
