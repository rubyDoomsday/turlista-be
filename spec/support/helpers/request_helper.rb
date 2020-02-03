# frozen_string_literal: true

module RequestHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def response_matches?(expectations = {})
    expect(JSON.parse(expectations.to_json).deep_symbolize_keys.keys).to include(*json.keys)
  end

  private

  def error_response
    { errors: [] }
  end
end
