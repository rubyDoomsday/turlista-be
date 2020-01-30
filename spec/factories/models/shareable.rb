# frozen_string_literal: true

FactoryBot.define do
  factory :shareable, class: "Shareable" do
    what { Faker::ChuckNorris.fact }
    trip_id { create(:trip).id }
    user_id { create(:user).id }
  end
end
