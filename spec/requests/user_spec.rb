# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :request do
  let(:headers) { basic_auth_headers }

  context "Authorization" do
    let(:path) { users_path }

    it "requires valid token" do
      headers = basic_auth_headers(nil)
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/unauthorized/)
    end
  end

  context "#create" do
    let(:path) { users_path }

    it "creates a user (with id)" do
      user = build(:user)
      post path, params: user.to_json, headers: headers
      response_matches?(user)

      expect(user.first_name).to eq json[:first_name]
      expect(user.last_name).to eq json[:last_name]
      expect(user.email).to eq json[:email]
    end

    it "creates a user (without id)" do
      user = build(:user)
      post path, params: user.attributes.except("id)").to_json, headers: headers
      response_matches?(user)

      expect(user.first_name).to eq json[:first_name]
      expect(user.last_name).to eq json[:last_name]
      expect(user.email).to eq json[:email]
    end

    it "raises error" do
      user = build(:user, :invalid)
      post path, params: user.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:email].first).to match(/email/)
    end
  end

  context "#show" do
    let(:user) { create(:user) }

    it "finds a user" do
      path = user_path(user.id)
      get path, headers: headers
      response_matches?(user)

      expect(user.first_name).to eq json[:first_name]
      expect(user.last_name).to eq json[:last_name]
      expect(user.email).to eq json[:email]
    end

    it "raises error" do
      path = user_path("invalidID123")
      get path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#update" do
    let(:user) { create(:user) }
    let(:path) { user_path(user.id) }

    it "updates a user" do
      update = build(:user).attributes.except("id")
      put path, params: update.to_json, headers: headers
      response_matches?(user)

      expect(update["first_name"]).to eq json[:first_name]
      expect(update["last_name"]).to eq json[:last_name]
      expect(update["last_name"]).to eq json[:last_name]
      expect(user.id).to eq json[:id]
    end

    it "raises error" do
      update = build(:user, :invalid).attributes
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:email].first).to match(/email/)
    end

    it "doesn't allow setting id to nil" do
      update = build(:user).attributes
      update["id"] = nil
      put path, params: update.to_json, headers: headers
      response_matches?(error_response)

      expect(json[:errors][:id].first).to match(/blank/)
    end
  end

  context "#destroy" do
    let(:user) { create(:user) }

    it "delets a user" do
      path = user_path(user.id)
      expect(User.find(user.id)).to be_present
      delete path, headers: headers

      expect(response.status).to eq 204
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error" do
      path = user_path("does-not-exist")
      delete path, headers: headers
      response_matches?(error_response)

      expect(json[:errors].first).to match(/not found/)
    end
  end

  context "#index/query" do
    it "lists user - without query"
    it "lists user - with query"
  end
end
