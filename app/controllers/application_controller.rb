# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_errors(errors, status: 400)
    render json: { errors: errors }, status: status
  end
end
