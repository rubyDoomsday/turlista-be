# frozen_string_literal: true

class Expense < ApplicationRecord
  # associations
  belongs_to :trip
  belongs_to :event, optional: true
  belongs_to :covered_by, class_name: "User"

  #validations
  validates :amount, presence: true
  validates :trip_id, presence: true
  validates :covered_by_id, presence: true
end
