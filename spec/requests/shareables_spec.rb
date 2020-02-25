# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShareablesController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:trip) { create(:trip) }

  context "Authorization" do
    let(:path) { trip_shareables_path(trip.id) }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { trip_shareables_path(trip.id) }

    it "creates a shareable" do
      shareable = build(:shareable)
      post path, params: shareable.to_json, headers: headers
      response_matches?(shareable)

      expect(json[:what]).to eq shareable.what
      expect(json[:trip_id]).to eq trip.id
    end

    it "raises error" do
      shareable = build(:shareable, :invalid)
      post path, params: shareable.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:what].first).to match(/blank/)
    end
  end

  context "#update" do
    let(:shareable) { create(:shareable) }
    let(:path) { trip_shareable_path(trip.id, shareable.id) }

    it "updates a trip" do
      update = build(:shareable).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(shareable)

      expect(json[:what]).to eq update["what"]
      expect(json[:user_id]).to eq update["user_id"]
      expect(json[:id]).to eq shareable.id
    end

    it "raises error" do
      update = build(:shareable, :invalid).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:what].first).to match(/blank/)
    end
  end

  context "#destroy" do
    let(:shareable) { create(:shareable) }
    let(:path) { trip_shareable_path(trip.id, shareable.id) }

    it "delets a trip" do
      expect(Shareable.find(shareable.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { Shareable.find(shareable.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = trip_shareable_path(trip.id, "id-does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    let(:shareables) { create_list(:shareable, 10, trip_id: trip.id) }
    let(:path) { trip_shareables_path(trip.id) }

    before(:each) do
      # lower page limit for testing purposes
      Pagination.configure do |c|
        c.page_limit = 5
      end
    end

    it "lists shareables - without query" do
      expect(shareables.count).to eq 10
      get path, headers: headers

      expect(response.status).to eq 200
      expect(json[:shareables].count).to eq 5
      expect(json[:meta][:total]).to eq 10
    end

    it "lists shareables - with query" do
      expect(shareables.count).to eq 10
      query = "what=#{shareables.first.what}"
      get path, params: { q: query }, headers: headers

      expect(response.status).to eq 200
      expect(json[:shareables].count).to eq 1
      expect(json[:meta][:total]).to eq 1
    end
  end
end
