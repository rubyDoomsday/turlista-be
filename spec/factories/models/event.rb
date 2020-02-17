# frozen_string_literal: true

FactoryBot.define do
  factory :event, class: "Event" do
    start_time { Faker::Time.between(from: Time.now.utc, to: (Time.now + 3.days).utc) }
    end_time { Faker::Time.between(from: Time.now.utc + 4.days, to: (Time.now + 6.days).utc) }
    category { %w[activity info lodging].sample }
    description { %w[breakfast taxi meeting].sample }
    title { Faker::ChuckNorris.fact }
    location { Faker::Address.full_address }
    trip_id { create(:trip).id }

    trait :invalid do
      title { nil }
    end
  end
end


