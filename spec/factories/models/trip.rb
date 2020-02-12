# frozen_string_literal: true

FactoryBot.define do
  factory :trip, class: "Trip" do
    title { Faker::Book.title }
    start_date { Faker::Time.between(from: Time.now.utc, to: (Time.now + 3.days).utc) }
    end_date { Faker::Time.between(from: (Time.now + 4.days).utc, to: (Time.now + 6.days).utc) }
    owner_id { create(:user).id }

    trait :invalid do
      title { nil }
    end
  end
end
