require "spec_helper"

describe "POST /api/public/users" do
  let(:path) { "/api/public/users" }

  context "when valid params" do
    let(:params) do
      {
        name: "Hey Buddy",
        email: "foo@bar.com",
        password: "asdfg12345",
        password_confirmation: "asdfg12345",
      }
    end

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "creates a new User" do
        expect { subject }.to change { User.count }.by(1)
      end
    end

    context "when creates a user with attributes" do
      before do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      subject(:user) { User.last }

      it { expect(user.name).to eq "Hey Buddy" }
      it { expect(user.email).to eq "foo@bar.com" }
    end

    context "when returns response" do
      let(:user) { User.last }

      before do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it { expect(response).to have_http_status :created }
      it { expect(response).to match_json_schema("public_api/user") }

      it "renders user as json" do
        expect(JSON.parse(response.body)).to eq(
          "id" => user.id,
          "name" => "Hey Buddy",
          "email" => "foo@bar.com",
        )
      end
    end
  end

  context "when invalid email is given" do
    let(:params) { { email: nil, password: "123", password_confirmation: "123" } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "does not create a new User" do
        expect { subject }.not_to change { User.count }
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

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns the error messages for email" do
        expect(JSON.parse(response.body)["email"]).to eq ["can't be blank", "is invalid"]
      end
    end
  end

  context "when password is empty" do
    let(:params) { { email: "foo@bar.com", password: "", password_confirmation: "" } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "does not create a new User" do
        expect { subject }.not_to change { User.count }
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

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns the error messages for password" do
        expect(JSON.parse(response.body)["password"]).to eq ["can't be blank"]
      end
    end
  end

  context "when password confirmation is invalid" do
    let(:params) { { email: "foo@bar.com", password: "112233", password_confirmation: "asdf" } }

    context "when performs request" do
      subject(:perform_request) do
        post(
          path,
          params: params,
          headers: { "ACCEPT" => "application/json" },
        )
      end

      it "does not create a new User" do
        expect { subject }.not_to change { User.count }
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

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns the error messages for password" do
        expect(JSON.parse(response.body)["password_confirmation"]).to include "doesn't match Password"
      end
    end
  end
end
