# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: %i[show update destroy]

  def index; end

  def show
    render json: @user, status: :success
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      render json: @user.to_json, status: :created
    else
      render_errors(@user.errors)
    end
  end

  def update
    @user.assign_attributes(user_params)

    if @user.valid?
      @user.save
      render json: @user, status: :success
    else
      render_errors(@user.errors)
    end
  end

  def destroy
    if @user.destroy
      render json: {}, status: :no_content
    else
      render_errors(@user.errors)
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  rescue StandardError
    render_errors(["not found"], status: 404)
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :trip_id)
  end
end
