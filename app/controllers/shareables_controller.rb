# frozen_string_literal: true

class ShareablesController < ApplicationController
  before_action :load_shareable, only: %i[show update destroy]

  def index
    @shareable = Shareable.paginate(
      query:   to_query(trip_id: params[:trip_id]),
      sort_by: query_params[:sort_by] || :what,
      order:   query_params[:order] || :asc,
      offset:  query_params[:offset]
    )

    render json: @shareable, status: 200
  end

  def create
    @shareable = Shareable.new(shareable_params)

    if @shareable.valid?
      @shareable.save
      render json: @shareable.to_json, status: 201
    else
      render_errors(@shareable.errors)
    end
  end

  def update
    if @shareable.update(shareable_params)
      render json: @shareable, status: 200
    else
      render_errors(@shareable.errors)
    end
  end

  def destroy
    @shareable.destroy
    render json: {}, status: 204
  end

  private

  def load_shareable
    @shareable = Shareable.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def shareable_params
    params.require(:shareable)
      .permit(:what, :user_id).tap do |p|
        p[:trip_id] = params[:trip_id]
      end
  end
end
