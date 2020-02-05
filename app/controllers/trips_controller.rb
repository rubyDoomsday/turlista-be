# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :load_trip, only: %i[show update destroy]

  def index
    @trips = Trip.paginate(
      query:   to_query(owner_id: params[:user_id]),
      sort_by: query_params[:sort_by] || :start_date,
      order:   query_params[:order] || :desc,
      offset:  query_params[:offset]
    )

    render json: @trips, status: 200
  end

  def show
    render json: @trip, status: 200
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.valid?
      @trip.save
      render json: @trip.to_json, status: 201
    else
      render_errors(@trip.errors)
    end
  end

  def update
    if @trip.update(trip_params)
      render json: @trip, status: 200
    else
      render_errors(@trip.errors)
    end
  end

  def destroy
    if @trip.destroy
      render json: {}, status: 204
    else
      render_errors(@trip.errors)
    end
  end

  private

  def load_trip
    @trip = Trip.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def trip_params
    params.require(:trip)
      .permit(:title, :start_date, :end_date, :participants).tap do |p|
        p[:owner_id] = params[:user_id]
      end
  end
end
