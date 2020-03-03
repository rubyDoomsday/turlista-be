# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExpensesController, type: :request do
  let(:headers) { basic_auth_headers }
  let(:trip) { create(:trip) }

  describe "For Trip" do
    context "Authorization" do
      let(:path) { trip_expenses_path(trip.id) }

      it "requires valid token" do
        headers = basic_auth_headers(nil)
        get path, headers: headers
        response_matches?(error_response)

        expect(json[:errors].first).to match(/unauthorized/)
      end
    end

    context "#create" do
      let(:path) { trip_expenses_path(trip.id) }

      it "creates a expense on a trip" do
        expense = build(:expense)
        post path, params: expense.to_json, headers: headers
        response_matches?(expense)

        expect(json[:amount]).to eq expense.amount
        expect(json[:description]).to eq expense.description
      end

      it "raises error" do
        expense = build(:expense, :invalid)
        post path, params: expense.to_json, headers: headers
        response_matches?(error_response)

        expect(json[:errors][:covered_by_id].first).to match(/blank/)
      end
    end

    context "#update" do
      let(:expense) { create(:expense) }
      let(:path) { trip_expense_path(trip.id, expense.id) }

      it "updates a expense" do
        update = build(:expense).attributes.except("id")
        put path, params: update.to_json, headers: headers
        response_matches?(expense)

        expect(json[:amount]).to eq update["amount"]
        expect(json[:description]).to eq update["description"]
        expect(json[:id]).to eq expense["id"]
      end

      it "raises error" do
        update = build(:expense, :invalid).attributes.except("id")
        put path, params: update.to_json, headers: headers
        response_matches?(error_response)

        expect(json[:errors][:covered_by_id].first).to match(/blank/)
      end
    end

    context "#destroy" do
      let(:expense) { create(:expense) }
      let(:path) { trip_expense_path(trip.id, expense.id) }

      it "delets a expense" do
        expect(Expense.find(expense.id)).to be_present
        delete path, headers: headers

        expect(response.status).to eq 204
        expect { Expense.find(expense.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raises error" do
        path = trip_expense_path(trip.id, "id-does-not-exist")
        delete path, headers: headers
        response_matches?(error_response)

        expect(json[:errors].first).to match(/not found/)
      end
    end

    context "#index/query" do
      let(:expenses) { create_list(:expense, 10, trip_id: trip.id) }
      let(:path) { trip_expenses_path(trip.id) }

      before(:each) do
        # lower page limit for testing purposes
        Pagination.configure do |c|
          c.page_limit = 5
        end
      end

      it "lists expenses - without query" do
        expect(expenses.count).to eq 10
        get path, headers: headers

        expect(response.status).to eq 200
        expect(json[:expenses].count).to eq 5
        expect(json[:meta][:total]).to eq 10
      end

      it "lists expenses - with query" do
        expect(expenses.count).to eq 10
        query = "amount=#{expenses.first.amount}"
        get path, params: { q: query }, headers: headers

        expect(response.status).to eq 200
        expect(json[:expenses].count).to eq 1
        expect(json[:meta][:total]).to eq 1
      end
    end
  end
end
