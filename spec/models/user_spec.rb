require "rails_helper"

describe User do
  describe "associations" do
    it { is_expected.to have_many(:documents) }
  end

  describe "validations" do
    context "standard validations" do
      subject { create :user }

      it { is_expected.to have_secure_password }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to validate_confirmation_of(:password) }

      it { is_expected.to validate_length_of(:name).is_at_most(255) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to validate_length_of(:password_digest).is_at_most(255) }
    end

    context "when obvious mistake in email" do
      let(:user) { build :user, email: "ops.com" }

      before { user.valid? }

      subject { user.errors[:email] }

      it { is_expected.to include "is invalid" }
    end
  end

  describe "email normalization" do
    context "when uppercase symbols" do
      let(:user) { create :user, email: "FOO@BAR.com" }

      subject { user.reload.email }

      before { user.save }

      it { is_expected.to eq "foo@bar.com" }
    end

    context "when trim spaces, tabs and newline" do
      let(:user) { create :user, email: " \t  foo@bar.com    \r\n " }

      subject { user.reload.email }

      before { user.save }

      it { is_expected.to eq "foo@bar.com" }
    end
  end

  describe "#auth_sessions" do
    context "when saves session" do
      let(:user) { create :user }
      let(:session) { Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest)) }

      before do
        user.sessions << session
        user.save
      end

      subject(:user_sessions) { user.reload.sessions }

      it "saves sessions" do
        expect(user_sessions.find(session.token)).to eq session
      end
    end

    context "when removes session" do
      let(:user) { create :user }
      let(:session) { Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest)) }

      before do
        user.sessions << session
        user.save
        user.sessions.invalidate(session)
        user.save
      end

      subject(:user_sessions) { user.reload.sessions }

      it "removes sessions" do
        expect(user_sessions).to eq Auth::Sessions.new([])
      end
    end
  end

  describe ".find_by_session" do
    context "when single user obtains the session" do
      let(:user) { create :user }
      let(:session) { Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest)) }

      before do
        user.sessions << session
        user.save

        create(:user).tap do |user|
          user.sessions << Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest))
          user.sessions << Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest))
          user.save
        end
      end

      subject { described_class.find_by_session(session) }

      it { is_expected.to eq user }
    end

    context "when multiple users obtain the session" do
      let(:session) { Auth::Session.new(token_provider: Auth::TokenProvider.new("foobar")) }

      before do
        2.times do
          create(:user).tap do |user|
            user.sessions << session
            user.sessions << Auth::Session.new(token_provider: Auth::TokenProvider.new(user.password_digest))
            user.save
          end
        end
      end

      subject { described_class.find_by_session(session) }

      it "raises SessionDuplicateError exception" do
        expect { subject }.to raise_exception User::SessionDuplicateError
      end
    end
  end
end
