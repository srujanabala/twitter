class UsersController < ApplicationController
	before_action :check_user_login, except: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.confirm_email(@user).deliver
			redirect_to tweets_path
		else
			render action: :new
		end
	end

	def show
		@user = User.find(params[:id])
		@user_tweets = @user.tweets
	end

	def edit
	end

	def update
		@current_user.update_attributes(user_params)
		redirect_to user_path(@current_user)
	end

	def confirm
		head :ok
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :handle, :avatar, :remove_avatar, :password, :password_confirmation)
	end
end
