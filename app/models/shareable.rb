# frozen_string_literal: true

class Shareable < ApplicationRecord
  # assocations
  belongs_to :trip
  belongs_to :user, optional: true, foreign_key: "user_id"

  # validations
  validates :what, presence: true
  validates :trip_id, presence: true
end
