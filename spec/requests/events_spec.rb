# frozen_string_literal: true

require "rails_helper"

RSpec.describe EventsController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:trip) { create(:trip) }

  context "Authorization" do
    let(:path) { trip_events_path(trip.id) }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { trip_events_path(trip.id) }

    it "creates a trip" do
      event = build(:event)
      post path, params: event.to_json, headers: headers
      response_matches?(event)

      expect(json[:title]).to eq event.title
      expect(json[:start_time]).to eq event.start_time.to_s
      expect(json[:end_time]).to eq event.end_time.to_s
    end

    it "raises error" do
      event = build(:event, :invalid)
      post path, params: event.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:title].first).to match(/blank/)
    end
  end

  context "#show" do
    let(:event) { create(:event) }
    let(:path) { trip_event_path(trip.id, event.id) }

    it "finds a trip" do
      get path, headers: headers
      response_matches?(event)

      expect(json[:title]).to eq event.title
      expect(json[:start_time]).to eq event.start_time.to_s
      expect(json[:end_time]).to eq event.end_time.to_s
    end

    it "raises error" do
      path = trip_event_path(trip.id, "invalidID123")
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#update" do
    let(:event) { create(:event) }
    let(:path) { trip_event_path(trip.id, event.id) }

    it "updates a trip" do
      update = build(:event).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(event)

      expect(json[:title]).to eq update["title"]
      expect(json[:start_time]).to eq update["start_time"].to_s
      expect(json[:end_time]).to eq update["end_time"].to_s
      expect(json[:id]).to eq event.id
    end

    it "raises error" do
      update = build(:event, :invalid).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:title].first).to match(/blank/)
    end
  end

  context "#destroy" do
    let(:event) { create(:event) }
    let(:path) { trip_event_path(trip.id, event.id) }

    it "delets a trip" do
      expect(Event.find(event.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { Event.find(event.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = trip_event_path(trip.id, "id-does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    let(:events) { create_list(:event, 10, trip_id: trip.id) }
    let(:path) { trip_events_path(trip.id) }

    before(:each) do
      # lower page limit for testing purposes
      Pagination.configure do |c|
        c.page_limit = 5
      end
    end

    it "lists events - without query" do
      expect(events.count).to eq 10
      get path, headers: headers

      expect(response.status).to eq 200
      expect(json[:events].count).to eq 5
      expect(json[:meta][:total]).to eq 10
    end

    it "lists events - with query" do
      expect(events.count).to eq 10
      query = "title=#{events.first.title}"
      get path, params: { q: query }, headers: headers

      expect(response.status).to eq 200
      expect(json[:events].count).to eq 1
      expect(json[:meta][:total]).to eq 1
    end
  end
end
