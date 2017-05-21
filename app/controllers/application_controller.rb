class ApplicationController < ActionController::API
	include Knock::Authenticable

	
	def get_current_user
		@current_user = current_user
	end

end
