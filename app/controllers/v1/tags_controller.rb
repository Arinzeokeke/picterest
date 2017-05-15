class TagsController < ApplicationController
	

	def index
		@tags = ActsAsTaggableOn::Tag.all.select(:name).order("created_at DESC")
	end

	

	
end