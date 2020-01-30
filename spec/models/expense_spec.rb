# frozen_string_literal: true

require "rails_helper"

RSpec.describe Expense do
  let(:expense) { build(:expense) }

  it "has a valid factory" do
    expect(expense).to be_valid
  end

  context "validations" do
    it { is_expected.to belong_to(:trip) }
    it { is_expected.to belong_to(:event).optional }

    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:trip_id) }
    it { is_expected.to validate_presence_of(:covered_by_id) }
  end
end



