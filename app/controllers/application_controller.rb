class ApplicationController < ActionController::API
	include Knock::Authenticable
	#before_action :underscore_params!
	
	def get_current_user
		@current_user = current_user
	end

	# private
	# def underscore_params!
 #    params.deep_transform_keys!(&:underscore)
 #    end

end
