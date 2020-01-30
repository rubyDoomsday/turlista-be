# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShoppingList do
  let(:shopping_list) { build(:shopping_list) }

  it "has a valid factory" do
    expect(shopping_list).to be_valid
  end

  context "validations" do
    it { is_expected.to belong_to(:trip) }

    it { is_expected.to have_many(:items) }

    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_inclusion_of(:kind).in_array(ShoppingList::Types::ALL) }

    it { is_expected.to validate_presence_of(:trip_id) }
  end
end

