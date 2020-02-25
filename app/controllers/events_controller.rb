# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :load_event, only: %i[show update destroy]

  def index
    @events = Event.paginate(
      query:   to_query(trip_id: params[:trip_id]),
      sort_by: query_params[:sort_by] || :start_time,
      order:   query_params[:order] || :asc,
      offset:  query_params[:offset]
    )

    render json: @events, status: 200
  end

  def show
    render json: @event, status: 200
  end

  def create
    @event = Event.new(event_params)

    if @event.valid?
      @event.save
      render json: @event.to_json, status: 201
    else
      render_errors(@event.errors)
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: 200
    else
      render_errors(@event.errors)
    end
  end

  def destroy
    @event.destroy
    render json: {}, status: 204
  end

  private

  def load_event
    @event = Event.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def event_params
    params.require(:event)
      .permit(:start_time,
              :end_time,
              :category,
              :description,
              :title,
              :location,
              :notes).tap do |p|
                p[:trip_id] = params[:trip_id]
              end
  end
end
