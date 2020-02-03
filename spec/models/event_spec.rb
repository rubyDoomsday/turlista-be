# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event do
  let(:event) { build(:event) }

  it "has a valid factory" do
    expect(event).to be_valid
  end

  context "validations" do
    it { is_expected.to belong_to(:trip) }

    it { is_expected.to have_one(:expense) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:trip_id) }
    it { is_expected.to validate_presence_of(:start_time) }

    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_inclusion_of(:category).in_array(Event::Categories::ALL) }

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_inclusion_of(:description).in_array(Event::Descriptions::ALL) }
  end
end
