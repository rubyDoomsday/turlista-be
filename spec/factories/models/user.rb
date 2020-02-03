# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: "User" do
    id { SecureRandom.uuid }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }

    trait :invalid do
      email { "invalid-email" }
    end
  end
end
