class V1::ProfilesController < ApplicationController
  before_action :get_profile, except: [:index]
  before_action :soft_authenticate_user
  before_action :set_current_user
  def show
  	
  end

  def index
  	@users = User.all
  end

  def followers
    @users = @user.followers
  
	render 'v1/profiles/index'
  end


  def following
    @users = @user.following_users	
	 render 'v1/profiles/index'
  end

  private
  def get_profile
  	@user = User.find_by(name: params[:username]) if params[:username]
    if @user.nil?
      render json: {errors: ['User not found']}, status: 404
    end
  end
end
