# frozen_string_literal: true

require "rails_helper"

RSpec.describe Item do
  let(:item) { build(:item) }

  it "has a valid factory" do
    expect(item).to be_valid
  end

  context "validations" do
    it { is_expected.to belong_to(:shopping_list) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:shopping_list_id) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Item::Statuses::ALL).with_message("invalid status") }
  end
end
