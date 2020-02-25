# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShoppingListsController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:trip) { create(:trip) }

  context "Authorization" do
    let(:path) { trip_shopping_lists_path(trip.id) }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { trip_shopping_lists_path(trip.id) }

    it "creates a shopping_list" do
      list = create(:shopping_list)
      post path, params: list.to_json, headers: headers
      response_matches?(list)

      expect(json[:volunteer_id]).to eq list.volunteer.id
      expect(json[:kind]).to eq list.kind
    end

    it "raises error" do
      list = build(:shopping_list, :invalid)
      post path, params: list.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:kind].first).to match(/blank/)
    end
  end

  context "#show" do
    let(:list) { create(:shopping_list) }

    it "finds a trip's shopping_list" do
      path = trip_shopping_list_path(trip.id, list.id)
      get path, headers: headers
      response_matches?(list)

      expect(json[:id]).to eq list.id
      expect(json[:volunteer_id]).to eq list.volunteer.id
      expect(json[:kind]).to eq list.kind
    end

    it "raises error" do
      path = trip_shopping_list_path(trip.id, "invalidID123")
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#update" do
    let(:list) { create(:shopping_list) }
    let(:path) { trip_shopping_list_path(trip.id, list.id) }

    it "updates a trip" do
      update = { kind: build(:shopping_list).kind }
      put path, params: update.to_json, headers: headers
      response_matches?(list)

      expect(json[:id]).to eq list.id
      expect(json[:kind]).to eq update[:kind]
    end

    it "raises error" do
      update = build(:shopping_list, :invalid).attributes
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:kind].first).to match(/blank/)
    end
  end

  context "#destroy" do
    let(:list) { create(:shopping_list) }
    let(:path) { trip_shopping_list_path(trip.id, list.id) }

    it "delets a trip" do
      expect(ShoppingList.find(list.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { ShoppingList.find(list.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = trip_shopping_list_path(trip.id, "id-does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    let(:lists) { create_list(:shopping_list, 10, trip_id: trip.id) }
    let(:path) { trip_shopping_lists_path(trip.id) }

    before(:each) do
      # lower page limit for testing purposes
      Pagination.configure do |c|
        c.page_limit = 5
      end
    end

    it "lists trips - without query" do
      expect(lists.count).to eq 10
      get path, headers: headers

      expect(response.status).to eq 200
      expect(json[:shopping_lists].count).to eq 5
      expect(json[:meta][:total]).to eq 10
    end

    it "lists trips - with query" do
      expect(lists.count).to eq 10
      query = "volunteer_id=#{lists.first.volunteer.id}"
      get path, params: { q: query }, headers: headers

      expect(response.status).to eq 200
      expect(json[:shopping_lists].count).to eq 1
      expect(json[:meta][:total]).to eq 1
    end
  end
end
