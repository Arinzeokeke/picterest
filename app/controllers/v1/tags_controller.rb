class V1::TagsController < ApplicationController
	

	def index
		@tags = Post.tag_counts.most_used
	end

	

	
end