class V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  before_action :set_current_user, except: [:create]
  def show
    
  end


  def create
  	@user = User.new(user_params)
  	if @user.save
      @current_user = @user
      render :create
    else
      render json: { errors: @user.errors.full_message }, status: :unprocessable_entity
    end
  end

  def update
   if current_user.update_attributes(user_params)
     @user = current_user
     render :show
     
   else
    
     render json: { errors: current_user.errors.full_message }, status: :unprocessable_entity
   end
  end

  def destroy
    current_user.destroy
    render json: {message: 'user deleted'}, status: 200
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_current_user
    @current_user = current_user
  end
end
