class V1::VotesController < ApplicationController
	before_action :find_post
	before_action :authenticate_user
	before_action :get_current_user
	def create
		@post.liked_by current_user
		render "v1/posts/show"
	end

	def destroy
		@post.unliked_by current_user
		render "v1/posts/show"
	end

	private
	def find_post
		@post = Post.friendly.find(params[:post_id]) if params[:post_id]
	end
end