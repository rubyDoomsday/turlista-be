# frozen_string_literal: true

class Trip < ApplicationRecord
  # associations
  belongs_to :owner, class_name: "User", inverse_of: :trips
  has_many :participants, class_name: "User", inverse_of: :trip
  has_many :shopping_lists
  has_many :shareables
  has_many :events
  has_many :expenses, inverse_of: :trip_id

  # validations
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, date: { after_or_equal_to: :start_date }
  validates :owner_id, presence: true
end
