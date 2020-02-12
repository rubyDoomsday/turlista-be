# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorization

  private

  # Provides a default method of rendering errors consistently across controllers
  # @param errors [Array] List of error strings, hashes or objects
  # @param status [Integer] HTTP status code. Default 400
  def render_errors(errors, status: 400)
    render json: { errors: errors }, status: status
  end

  # converts the :q param to a DB query and merges in the provided default options
  # @param options [Hash<Symbol><String>] The default query hash
  # @return [Hash] Ruby hash options for ActiveRecord query
  def to_query(options = {})
    return options unless params[:q].present?

    queries = params[:q].split("&")

    queries.each_with_object({}) do |q, h|
      k, v = q.split("=")
      h[k.to_sym] = v
    end.merge(options)
  end

  def query_params
    params.permit(:sort_by, :q, :order, :offset)
  end
end
