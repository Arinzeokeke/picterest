class V1::FollowsController < ApplicationController
	before_action :authenticate_user, except: [:show]
	before_action :soft_authenticate_user, only: [:show]
	before_action :get_user
	before_action :set_current_user


	def show
		@users = @user.following_users
		render 'v1/profiles/index'
	end

	def create
		current_user.follow(@user) unless current_user.following?(@user) and current_user != @user 
		render 'v1/profiles/show'
	end

	def destroy
		current_user.stop_following(@user) if current_user.following?(@user) 
		render 'v1/profiles/show'
	end

	private
	def get_user
		@user = User.find_by(name: params[:profile_username])
    	if @user.nil?
      		render json: {errors: ["User doesn't exist"]}, status: 404
    	end
	end
end