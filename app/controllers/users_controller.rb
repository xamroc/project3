class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to @user
  end

  def show
  end

  def update
    if @user.update(params[:user].permit(:email, :password, :password_confirmation, :salt, :fish))
      redirect_to root_url
    else
      render text: 'Edit user failed.'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :salt, :fish)
  end

  def set_user
    @user = User.find(params[:id])
  end

end