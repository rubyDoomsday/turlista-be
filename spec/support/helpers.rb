# frozen_string_literal: true

require_relative "helpers/request_helper"

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end
