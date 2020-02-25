# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: "Item" do
    name { Faker::Name.name }
    status { %w[needed got unavailable].sample }
    shopping_list_id { create(:shopping_list).id }

    trait :invalid do
      status { "invalid" }
    end
  end
end
