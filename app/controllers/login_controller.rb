class LoginController < ApplicationController
  def new_session
  	@user = User.new
  end

  def create_session
  	if env['omniauth.auth'] # Check if user tried to login through OAuth
      user = User.from_omniauth(env['omniauth.auth']) # Get user from OAuth
    else # If not through OAuth
      user = User.find_by(email: params[:user][:email]) # Check if a user matches the email address
      unless user && user.authenticate(params[:user][:password]) # Unless a user exists and is authenticated
        user = nil
      end
    end

    if user
  		session[:user_id] = user.id
  		redirect_to user_path(user)
  	else
      flash[:error] = "Incorrect Password"
  		redirect_to login_path
  	end
  end

  def logout
    reset_session
    redirect_to login_path
  end
end
