class SessionController < ApplicationController

  def new
    redirect_to root_url, notice: "You are logged in." if current_user
  end

  def create
    if params[:user][:password].blank?
      PasswordResetter.new(flash).handle_reset_request(user_params)
    else
      return if log_user_in( UserAuthenticator.new(session,flash).authenticate_user(user_params) )
    end
    render :new
  end

  def destroy
    log_user_out
    render text: "Log the user out."
    redirect_to login_url, notice: "You've successfully logged out."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end