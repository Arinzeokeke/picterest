class V1::PostsController < ApplicationController
	before_action :find_post, except: [:index, :create]
	before_action :authenticate_user, only: [:create, :update, :destroy, :feed, :liked]
	#before_action :check_user, only: [:update, :destroy]


	def index
		if params[:liked] && User.find_by(name: params[:liked])
			user = User.find_by(name: params[:liked])
			@posts = user.get_up_voted Post
		else
			@posts = Post.all
		end
		
		filter_query
	end

	def create
		@post = current_user.post.new(post_params)
		if @post.save
			render 'v1/posts/show'
		else
			render json: { errors: @post.errors}, status: :unprocessable_entity
		end
	end

	def feed
		@posts = Post.includes(:user).where(user: current_user.following_users)
		filter_query
		render 'v1/posts/index'
	end

	def liked
		@posts = current_user.get_up_voted Post
		filter_query
		render 'v1/posts/index'
	end

	def update
		if current_user != @user
			if @post.update(post_params)
				render 'v1/posts/show'
			else
				render json: { errors: @post.errors}, status: :unprocessable_entity
			end
		else
			render json: {error: "Forbidden. You are not the owner of post"}, status: 400
		end
	end

	def show
	end

	def destroy
		if current_user != @post.user
			@post.destroy
    		render json: {message: 'post deleted'}, status: 200		
    	else
    		render json: {error: "Forbidden. You are not the owner of post"}, status: 400
		end

	end



	private
	def find_post
		@post = Post.find(params[:id]) if params[:id]
	end

	def post_params
    	params.require(:post).permit(:title, :url, :tag_list)
    end



    def filter_query
    	if params[:tag]

    		tag =  ActsAsTaggableOn::Tag.find_by(:name => params[:tag])
    		@posts = @posts.tagged_with(@tag.name).order("created_at DESC")
    	end
    	if params[:author] && (user = User.find_by(name: params[:user]))
			@posts = @posts.where(user_id: user.id) if params[:user]
		end
		@posts = @posts.limit(params[:limit].to_i) if params[:limit]
		@posts = @posts.offset(params[:offset].to_i) if params[:offset]
		@posts = @posts.order(params[:order]) if params[:order] && ['desc', 'asc'].include?(params[:order])
    end
end