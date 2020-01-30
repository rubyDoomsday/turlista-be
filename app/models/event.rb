# frozen_string_literal: true

class Event < ApplicationRecord
  module Categories
    ALL = [
      ACTIVITY = "activity",
      INFO     = "info",
      LODGING  = "lodging",
      MEAL     = "meal",
      TRAVEL   = "travel"
    ].freeze
  end

  module Descriptions
    ALL = [
      ADVENTURE = "adventure",
      APP_RIDE  = "app-ride",
      BREAKFAST = "breakfast",
      LUNCH     = "lunch",
      DINNER    = "dinner",
      CAR       = "car",
      FLIGHT    = "flight",
      HOTEL     = "hotel",
      TAXI      = "taxi",
      MEETING   = "meeting"
    ].freeze
  end

  # associations
  belongs_to :trip

  # validations
  validates :start_time, presence: true
  validates :category, presence: true, inclusion: { in: Event::Categories::ALL }
  validates :description, presence: true, inclusion: { in: Event::Descriptions::ALL }
  validates :title, presence: true
  validates :trip_id, presence: true
end

