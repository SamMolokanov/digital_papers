require "rails_helper"

RSpec.describe Document do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    subject { create :document }

    it { is_expected.to validate_presence_of(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
  end

  # TODO: move to concern
  describe "name normalization" do
    context "when uppercase symbols" do
      let(:document) { create :document, name: "FOO_BAR" }

      subject { document.reload.name }

      before { document.save }

      it { is_expected.to eq "foo_bar" }
    end

    context "when trim spaces, tabs and newline" do
      let(:document) { create :document, name: " \t  foo_bar    \r\n " }

      subject { document.reload.name }

      before { document.save }

      it { is_expected.to eq "foo_bar" }
    end
  end
end
