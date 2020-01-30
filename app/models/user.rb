# frozen_string_literal: true

class User < ApplicationRecord
  # # associations
  belongs_to :trip, inverse_of: :participants, optional: true, foreign_key: "trip_id"
  has_many :trips, inverse_of: :owner, foreign_key: "owner_id"
  #
  # validations
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitve: false }
end
