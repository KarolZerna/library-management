# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def profile
    render json: current_user
  end

  def create
    @user = User.new(user_params)
    raise LibraryErrorHandler::ClientError.new(message: 'Failed to create user', errors: @user.errors.full_messages) unless @user.save

    render json: @user, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end
