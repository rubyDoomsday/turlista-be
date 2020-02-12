# frozen_string_literal: true

# Authorization concern handles parsing the Authorization token header in the
# request from the client.
module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_client
  end

  # TODO: Authorization "wire-frame" handles only a single token at the moment.
  def authorize_client
    return if request.headers["Authorization"] == "temporary-token"

    render json: { errors: ["unauthorized"] }, status: 401
  end
end
