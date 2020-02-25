# frozen_string_literal: true

require "simplecov"

SimpleCov.profiles.define "no_vendor_coverage" do
  load_profile "rails"
  add_filter "vendor" # Don't include vendored stuff
end

SimpleCov.start "no_vendor_coverage"
