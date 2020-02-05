# frozen_string_literal: true

# Sets the default Time#to_s format to ISO8601
Time::DATE_FORMATS[:default] = Time::DATE_FORMATS[:iso8601]

module ActiveSupport
  # Overrides Rails Active Support TimeWithZone#as_json default serialization
  # to us the TimeWithZone#to_s. This ensures that encoded formats match.
  #
  # @see: https://github.com/rails/rails/blob/f33d52c95217212cbacc8d5e44b5a8e3cdc6f5b3/activesupport/lib/active_support/time_with_zone.rb#L167
  module TimeWithZoneOverrides
    def as_json(_options = {})
      to_s
    end
  end

  class TimeWithZone
    prepend TimeWithZoneOverrides
  end
end
