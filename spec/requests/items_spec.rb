# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemsController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:list) { create(:shopping_list) }

  context "Authorization" do
    let(:path) { trip_shopping_list_items_path(list.trip_id, list.id) }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { trip_shopping_list_items_path(list.trip_id, list.id) }

    it "creates a item" do
      item = build(:item)
      post path, params: item.to_json, headers: headers
      response_matches?(item)

      expect(json[:name]).to eq item.name
      expect(json[:status]).to eq item.status
      expect(json[:shopping_list_id]).to eq list.id
    end

    it "raises error" do
      item = build(:item, :invalid)
      post path, params: item.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:status].first).to match(/invalid/)
    end
  end

  context "#update" do
    let(:item) { create(:item) }
    let(:path) { trip_shopping_list_item_path(list.trip_id, list.id, item.id) }

    it "updates a item" do
      update = build(:item).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(item)

      expect(json[:name]).to eq update["name"]
      expect(json[:status]).to eq update["status"]
      expect(json[:id]).to eq item.id
    end

    it "raises error" do
      update = build(:item, :invalid).attributes
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:status].first).to match(/invalid/)
    end
  end

  context "#destroy" do
    let(:item) { create(:item) }
    let(:path) { trip_shopping_list_item_path(list.trip_id, list.id, item.id) }

    it "deletes a item" do
      expect(Item.find(item.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = trip_shopping_list_item_path(list.trip_id, list.id, "id-does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    let(:items) { create_list(:item, 10, shopping_list_id: list.id) }
    let(:path) { trip_shopping_list_items_path(list.trip_id, list.id) }

    before(:each) do
      # lower page limit for testing purposes
      Pagination.configure do |c|
        c.page_limit = 5
      end
    end

    it "lists items - without query" do
      expect(items.count).to eq 10
      get path, headers: headers

      expect(response.status).to eq 200
      expect(json[:items].count).to eq 5
      expect(json[:meta][:total]).to eq 10
    end

    it "lists items - with query" do
      expect(items.count).to eq 10
      query = "name=#{items.first.name}"
      get path, params: { q: query }, headers: headers

      expect(response.status).to eq 200
      expect(json[:items].count).to eq 1
      expect(json[:meta][:total]).to eq 1
    end
  end
end
