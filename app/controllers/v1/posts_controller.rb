class V1::PostsController < ApplicationController
	before_action :find_post, except: [:index, :create]
	before_action :authenticate_user, only: [:create, :update, :destroy, :feed, :liked]
	before_action :get_current_user, only: [:create, :update, :destroy, :feed, :liked]


	def index

		if params[:liked].present? && User.find_by(name: params[:liked])
			user = User.find_by(name: params[:liked])
			@posts = user.get_up_voted Post
		else
			@posts = Post.all
		end

		filter_query
	end

	def create
		#byebug
		@post = current_user.posts.new(post_params)
		if @post.save
			render 'v1/posts/show'
		else
			render json: { errors: @post.errors.full_message }, status: :unprocessable_entity
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
			@post.slug = nil
			if @post.update(post_params)
				render 'v1/posts/show'
			else
				render json: { errors: @post.errors.full_message }, status: :unprocessable_entity
			end
		else
			render json: {errors: ["Forbidden. You are not the owner of post"]}, status: 403
		end
	end

	def show
	end

	def destroy
		if current_user == @post.user
			@post.destroy
    		render json: {message: 'post deleted'}, status: 200		
    	else
    		render json: {errors: ["Forbidden. You are not the owner of post"]}, status: 403
		end

	end



	private
	def find_post
		@post = Post.friendly.find(params[:id]) if params[:id]
	end

	def post_params

    	params.require(:post).permit(:title, :url, :tag_list => [])
    end



    def filter_query
    	if params[:tag].present?

    		tag =  ActsAsTaggableOn::Tag.find_by(:name => params[:tag])
    		@posts = @posts.tagged_with(tag.name).order("created_at DESC")
    	end
    	if params[:author].present? && (user = User.find_by(name: params[:author]))
			@posts = @posts.where(user_id: user.id) #if params[:author].present?
		end
		if params[:limit].present?
			@posts = @posts.limit(params[:limit].to_i) 
		else
			@posts = @posts.limit(25)
		end
		@posts = @posts.offset(params[:offset].to_i) if params[:offset].present?
		@posts = @posts.order("created_at #{params[:order]}") if params[:order].present? && ['desc', 'asc'].include?(params[:order].downcase)
    	
    end
end
