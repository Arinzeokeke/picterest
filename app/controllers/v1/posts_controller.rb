class PostsController < ApplicationController
	before_action :find_post, except: [:index]
	before_action :authenticate_user, only: [:create, :update, :destroy]
	before_action :check_user, only: [:update, :destroy]


	def index
		@post = Post.all
		if params[:user]
			@post = @post.where(:user_id: params[:user])
			
	end

	def create
		@post = current_user.post.new(post_params)
		if @post.save
			render 'v1/posts/show'
		else
			render json: { errors: @post.errors}, status: :unprocessable_entity
		end
	end

	def update
		if @post.update(post_params)
			render 'v1/posts/show'
		else
			render json: { errors: @post.errors}, status: :unprocessable_entity
		end
	end

	def show
	end

	def destroy
		@post.destroy
    	render json: {message: 'post deleted'}, status: 200
	end



	private
	def find_post
		@post = Post.find(params[:id]) if params[:id]
	end

	def post_params
    	params.require(:post).permit(:title, :url)
    end

    def check_user
    	if current_user != @post.user
    		render json {error: "Forbidden. You are not the owner of post"}, status: 400
    		return
    	end
    end
end