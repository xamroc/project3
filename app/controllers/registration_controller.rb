class RegistrationController < ApplicationController

  def new

  end

  def create
    @user = User.new( user_params )
    if @user.save
      log_user_in( @user, "You are now logged in." )
    else
      flash.now[:alert] = "Passwords don't match."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end