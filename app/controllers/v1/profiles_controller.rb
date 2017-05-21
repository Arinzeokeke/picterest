class V1::ProfilesController < ApplicationController
  before_action :get_profile, except: [:index]
  def show
  	
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
  	@user = User.find_by(name: params[:username]) if params[:username]
  end
end
