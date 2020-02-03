# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  let(:user) { build(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:first_name) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to have_many(:trips).with_foreign_key("owner_id") }
    it { is_expected.to belong_to(:trip).with_foreign_key("trip_id").optional }

    it "validates email format" do
      user = build(:user, email: "not-email")
      expect(user.valid?).to eq false
      expect(user.errors.messages.keys).to include(:email)
    end
  end
end
