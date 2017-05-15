class VotesController < ApplicationController
	before_filter :find_post
	before_action :authenticate_user

	def create
		@post.liked_by current_user
		render json: {message: 'post liked'}, status: 200
	end

	def destroy
		@post.unliked_by current_user
		render json: {message: 'post unliked'}, status: 200
	end

	private
	def find_post
		@post = Post.find(params[:post_id]) if params[:post_id]
	end
end