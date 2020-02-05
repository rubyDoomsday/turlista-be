# frozen_string_literal: true

module RequestHelper
  # Builds a valid authentication hash
  # @param token [String] the token
  # @return [Hash] Header hash
  def basic_auth_headers(token = "temporary-token")
    {
      "Authorization" => token,
      "Content-type" => "application/json",
      "Accept" => "application/json"
    }
  end

  # Parses a response body to a ruby hash
  # @return [Hash] The JSON hash
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  # compares Hash keys from an expectation to the json response
  # @param expectations [Hash|Object] Must respond to .to_json
  # @return [Boolean]
  def response_matches?(expectations = {})
    expect(JSON.parse(expectations.to_json).deep_symbolize_keys.keys).to include(*json.keys)
  end

  private

  def error_response
    { errors: [] }
  end
end
