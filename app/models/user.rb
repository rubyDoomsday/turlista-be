# frozen_string_literal: true

class User < ApplicationRecord
  # associations
  belongs_to :trip, inverse_of: :participants, optional: true, foreign_key: "trip_id"
  has_many :trips, inverse_of: :owner, foreign_key: "owner_id"

  # hooks
  before_validation ->(u) { u.id = SecureRandom.uuid if u.id.nil? }, on: :create

  # validations
  validates :id, presence: true, uuid: true
  validates :first_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitve: false },
                    email: true
end
