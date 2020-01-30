# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_list, class: "ShoppingList" do
    kind { %w[grocery gear].sample }
    total { Faker::Commerce.price }
    trip_id { create(:trip).id }
    volunteer_id { create(:user).id }
  end
end
