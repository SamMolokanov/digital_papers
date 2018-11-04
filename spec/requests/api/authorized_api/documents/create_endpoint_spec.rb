require "rails_helper"

describe "POST /api/authorized/documents" do
  let(:path) { "/api/authorized/documents" }

  context "when valid params" do
    let(:user) { create :user }

    # TODO: create an Rspec helper for auth user
    let(:session) { Auth::Session.new(pepper: user.password_digest) }

    before do
      user.sessions << session
      user.save
    end

    context "when performs request" do
      let(:params) do
        {
          name: "Some Document Name",
          file: fixture_file_upload("files/book.jpg", "image/jpg"),
        }
      end

      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer #{session.token}" },
        )
      end

      it "creates a document for the user" do
        expect { subject }.to change { user.reload.documents.count }.by(1)
      end

      it { subject; expect(response).to have_http_status :created }
    end

    context "when creates a document with the name" do
      let(:params) do
        {
          name: "\r\n Some Document Name \t",
          file: fixture_file_upload("files/book.jpg", "image/jpg"),
        }
      end

      before do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer #{session.token}" },
        )
      end

      subject { user.documents.last.name }

      it "creates a document with the normalized name" do
        is_expected.to eq "some document name"
      end
    end

    context "when name is not provided" do
      before do
        post(
          path,
          params: { file: fixture_file_upload("files/book.jpg", "image/jpg") },
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer #{session.token}" },
        )
      end

      subject { user.documents.last.name }

      it "creates a document with the file name" do
        is_expected.to eq "book.jpg"
      end
    end
  end

  context "when invalid params" do
    let(:user) { create :user }

    # TODO: create an Rspec helper for auth user
    let(:session) { Auth::Session.new(pepper: user.password_digest) }

    before do
      user.sessions << session
      user.save
    end

    context "when file is not provided" do
      before do
        post(
          path,
          params: { name: "foobar" },
          headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer #{session.token}" },
        )
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  context "when invalid token is given" do
    let(:params) do
      {
        name: "Some Document Name",
        file: fixture_file_upload("files/book.jpg", "image/jpg"),
      }
    end

    before do
      post(
        path,
        params: params,
        headers: { "ACCEPT" => "application/json", "Authorization" => "Bearer fooobar" },
      )
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
