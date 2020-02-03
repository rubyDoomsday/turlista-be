# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  def validate_each(record, attribute, value)
    return if value =~ REGEX

    record.errors[attribute] << (options[:message] || "is not an email")
  end
end
