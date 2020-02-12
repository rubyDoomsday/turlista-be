# frozen_string_literal: true

class UuidValidator < ActiveModel::EachValidator
  REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.freeze

  def validate_each(record, attribute, value)
    return if REGEX.match?(value.to_s.downcase)

    record.errors[attribute] << (options[:message] || "not a valid UUID")
  end
end
