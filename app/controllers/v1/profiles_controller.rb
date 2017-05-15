class V1::ProfilesController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.all
  end

  def followers
  	@users = @user.following_users
	render 'v1/profiles/index'
  end


  def following
  	@users = @user.followers
	render 'v1/profiles/index'
  end

  private
  def get_profile
  	@user = User.find_by(username: params[:username]) if params[:username]
  end
end
