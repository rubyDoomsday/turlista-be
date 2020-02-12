# frozen_string_literal: true

require "rails_helper"

RSpec.describe Trip do
  let(:trip) { build(:trip) }

  it "has a valid factory" do
    expect(trip).to be_valid
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:owner_id) }

    it { is_expected.to validate_presence_of(:start_date) }

    it 'validates start before end date' do
      expect(
        build(:trip,
              start_date: Time.now + 1.day,
              end_date: Time.now - 1.day).valid?
      ).to eq false
    end

    it 'validates start before end date' do
      expect(
        build(:trip,
              start_date: Time.now.end_of_day,
              end_date: nil).valid?
      ).to eq true
    end
  end
end

