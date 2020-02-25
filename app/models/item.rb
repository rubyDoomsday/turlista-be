# frozen_string_literal: true

class Item < ApplicationRecord
  module Statuses
    ALL = [
      NEEDED      = "needed",
      GOT         = "got",
      UNAVAILABLE = "unavailable"
    ].freeze
  end

  # associations
  belongs_to :shopping_list

  # validations
  validates :name, presence: true
  validates :status, inclusion: { in: Item::Statuses::ALL, message: "invalid status" }
  validates :shopping_list_id, presence: true

  attribute :status, :string, default: Item::Statuses::NEEDED
end
