require 'pry'

class UsersController < ApplicationController

  respond_to :json
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = if params[:id]
      User.where('id in (?)',params[:id].split(','))
    else
      @users = User.all
    end
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      head :created, location: user_url(user)
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def update
    head @user.update(user_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @user.destroy ? :no_content : :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    head :not_found unless @user = User.where('id in (?)', params[:id]).take
  end

end