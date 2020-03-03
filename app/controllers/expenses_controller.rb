# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :load_expense, only: %i[update destroy]

  def index
    @expenses = Expense.paginate(
      query:   to_query(trip_id: params[:trip_id]),
      sort_by: query_params[:sort_by] || :created_at,
      order:   query_params[:order] || :desc,
      offset:  query_params[:offset]
    )

    render json: @expenses, status: 200
  end

  def create
    @expense = Expense.new(event_params)

    if @expense.valid?
      @expense.save
      render json: @expense.to_json, status: 201
    else
      render_errors(@expense.errors)
    end
  end

  def update
    if @expense.update(event_params)
      render json: @expense, status: 200
    else
      render_errors(@expense.errors)
    end
  end

  def destroy
    @expense.destroy
    render json: {}, status: 204
  end

  private

  def load_expense
    @expense = Expense.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def event_params
    params.require(:expense)
      .permit(:amount,
              :event_id,
              :covered_by_id,
              :description).tap do |p|
                p[:trip_id] = params[:trip_id]
                p[:event_id] = params[:event_id] if params[:event_id].present?
              end
  end
end
