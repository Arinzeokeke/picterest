class ApplicationController < ActionController::API
	include Knock::Authenticable
	#before_action :underscore_params!
	
	def set_current_user
		@current_user = current_user if current_user
	end

	# private
	# def underscore_params!
 #    params.deep_transform_keys!(&:underscore)
 #    end

end
