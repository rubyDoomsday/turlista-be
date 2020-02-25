# frozen_string_literal: true

class ShoppingListsController < ApplicationController
  before_action :load_list, only: %i[show update destroy]

  def index
    @lists = ShoppingList.paginate(
      query:   to_query(trip_id: params[:trip_id]),
      sort_by: query_params[:sort_by] || :kind,
      order:   query_params[:order] || :desc,
      offset:  query_params[:offset]
    )

    render json: @lists, status: 200
  end

  def show
    render json: @list, status: 200
  end

  def create
    @list = ShoppingList.new(list_params)

    if @list.valid?
      @list.save
      render json: @list.to_json, status: 201
    else
      render_errors(@list.errors)
    end
  end

  def update
    if @list.update(list_params)
      render json: @list, status: 200
    else
      render_errors(@list.errors)
    end
  end

  def destroy
    if @list.destroy
      render json: {}, status: 204
    else
      render_errors(@list.errors)
    end
  end

  private

  def load_list
    @list = ShoppingList.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def list_params
    params.require(:shopping_list)
      .permit(:volunteer_id, :trip_id, :items, :kind)
  end
end
