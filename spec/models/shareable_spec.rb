# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shareable do
  let(:shareable) { build(:shareable) }

  it "has a valid factory" do
    expect(shareable).to be_valid
  end

  context "validations" do
    it { is_expected.to belong_to(:trip) }
    it { is_expected.to belong_to(:user).optional }

    it { is_expected.to validate_presence_of(:what) }
    it { is_expected.to validate_presence_of(:trip_id) }
  end
end

