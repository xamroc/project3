require 'pry'

class UsersController < ApplicationController

  respond_to :json
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = if params[:id]
      user_clause = @user ? "and user_id = #{@user.id}" : ""

      User.where('id in (?)',params[:id].split(','))
    else
      @user ? @user.tools : User.all
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

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to root_url
      # head :no_content
    else
      render :edit
      head :unprocessable_entity
    end
  end

  def destroy
    head @user.destroy ? :no_content : :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :description, :avatar, :facebook, :mobile_number)
  end

  def set_user
    head :not_found unless @user =
      User.includes(:tools).where('id in (?)', params[:id]).take
  end

end