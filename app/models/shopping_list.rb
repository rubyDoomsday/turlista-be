# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  module Types
    ALL = [
      GROCERY = "grocery",
      BOOZE   = "booze-a-hol",
      GEAR    = "gear"
    ].freeze
  end

  # assocations
  belongs_to :trip

  has_many :items

  has_one :volunteer, class_name: "User", inverse_of: :user

  # validations
  validates :kind, presence: true, inclusion: { in: ShoppingList::Types::ALL }
  validates :trip_id, presence: true
end
