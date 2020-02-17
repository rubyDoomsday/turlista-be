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

  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items

  belongs_to :volunteer, class_name: "User", optional: true, inverse_of: :shopping_list

  # validations
  validates :kind, presence: true, inclusion: { in: ShoppingList::Types::ALL }
  validates :trip_id, presence: true
end
