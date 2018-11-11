require "rails_helper"

describe Api::Authentication::Middleware do
  describe "#call" do
    let(:app) { -> (_env) { [200, {}, ["OK"]] } }

    context "when request has a valid token in the header" do
      let(:user) { create :user }
      let(:session) { Auth::Session.new(pepper: user.password_digest) }

      let(:env) do
        { "HTTP_AUTHORIZATION" => "Bearer #{session.token}" }
      end

      before do
        user.sessions << session
        user.save
      end

      subject { described_class.new(app).call(env) }

      it { expect(subject).to eq([200, {}, ["OK"]]) }
    end

    context "when request has an invalid token in the header" do
      let(:env) do
        { "HTTP_AUTHORIZATION" => "Bearer foobar" }
      end

      subject { described_class.new(app).call(env) }

      it { expect { subject }.to raise_exception Api::Authentication::Error }
    end

    context "when request does not have a valid token in the header" do
      let(:env) do
        { "FOO" => "BAR" }
      end

      subject { described_class.new(app).call(env) }

      it { expect { subject }.to raise_exception Api::Authentication::Error }
    end
  end
end
