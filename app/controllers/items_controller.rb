# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :load_trip, only: %i[show update destroy]

  def index
    @items = Item.paginate(
      query:   to_query(shopping_list_id: params[:shopping_list_id]),
      sort_by: query_params[:sort_by] || :name,
      order:   query_params[:order] || :asc,
      offset:  query_params[:offset]
    )

    render json: @items, status: 200
  end

  def create
    @item = Item.new(item_params)

    if @item.valid?
      @item.save
      render json: @item.to_json, status: 201
    else
      render_errors(@item.errors)
    end
  end

  def update
    if @item.update(item_params)
      render json: @item, status: 200
    else
      render_errors(@item.errors)
    end
  end

  def destroy
    @item.destroy
    render json: {}, status: 204
  end

  private

  def load_trip
    @item = Item.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def item_params
    params.require(:item)
      .permit(:name, :status).tap do |p|
        p[:shopping_list_id] = params[:shopping_list_id]
      end
  end
end
