# frozen_string_literal: true

class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    options.keys.each do |terminator|
      send(terminator, record, attribute, options[terminator])
    end
  end

  private

  def after_or_equal_to(record, attrib, terminator)
    return if record.send(attrib) >= record.send(terminator)

    record.errors.add(attrib, "must be after or equal to #{terminator}")
  end
end


