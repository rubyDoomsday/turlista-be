# frozen_string_literal: true

require "rails_helper"

RSpec.describe TripsController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:user) { create(:user) }

  context "Authorization" do
    let(:path) { user_trips_path(user.id) }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { user_trips_path(user.id) }

    it "creates a trip" do
      trip = build(:trip)
      post path, params: trip.to_json, headers: headers
      response_matches?(trip)

      expect(json[:title]).to eq trip.title
      expect(json[:start_date]).to eq trip.start_date.to_s
      expect(json[:end_date]).to eq trip.end_date.to_s
    end

    it "raises error" do
      trip = build(:trip, :invalid)
      post path, params: trip.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:title].first).to match(/blank/)
    end
  end

  context "#show" do
    let(:trip) { create(:trip) }
    let(:path) { user_trip_path(user.id, trip.id) }

    it "finds a trip" do
      get path, headers: headers
      response_matches?(trip)

      expect(json[:title]).to eq trip.title
      expect(json[:start_date]).to eq trip.start_date.to_s
      expect(json[:end_date]).to eq trip.end_date.to_s
    end

    it "raises error" do
      path = user_trip_path(user.id, "invalidID123")
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#update" do
    let(:trip) { create(:trip) }
    let(:path) { user_trip_path(user.id, trip.id) }

    it "updates a trip" do
      update = build(:trip).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(trip)

      expect(json[:title]).to eq update["title"]
      expect(json[:start_date]).to eq update["start_date"].to_date.to_s
      expect(json[:end_date]).to eq update["end_date"].to_date.to_s
      expect(json[:id]).to eq trip.id
    end

    it "raises error" do
      update = build(:trip, :invalid).attributes
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:title].first).to match(/blank/)
    end
  end

  context "#destroy" do
    let(:trip) { create(:trip) }
    let(:path) { user_trip_path(user.id, trip.id) }

    it "delets a trip" do
      expect(Trip.find(trip.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { Trip.find(trip.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = user_trip_path(user.id, "id-does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    let(:trips) { create_list(:trip, 10, owner_id: user.id) }
    let(:path) { user_trips_path(user.id) }

    before(:each) do
      # lower page limit for testing purposes
      Pagination.configure do |c|
        c.page_limit = 5
      end
    end

    it "lists trips - without query" do
      expect(trips.count).to eq 10
      get path, headers: headers

      expect(response.status).to eq 200
      expect(json[:trips].count).to eq 5
      expect(json[:meta][:total]).to eq 10
    end

    it "lists trips - with query" do
      expect(trips.count).to eq 10
      query = "title=#{trips.first.title}"
      get path, params: { q: query }, headers: headers

      expect(response.status).to eq 200
      expect(json[:trips].count).to eq 1
      expect(json[:meta][:total]).to eq 1
    end
  end
end
