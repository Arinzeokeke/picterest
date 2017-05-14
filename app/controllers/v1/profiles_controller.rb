class V1::ProfilesController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.all
  end
end
