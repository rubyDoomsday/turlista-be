# frozen_string_literal: true

FactoryBot.define do
  factory :expense, class: "Expense" do
    amount { Faker::Commerce.price }
    trip_id { create(:trip).id }
    covered_by_id { create(:user).id }
  end
end


