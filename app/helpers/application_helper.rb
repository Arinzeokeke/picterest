module ApplicationHelper
	def user_logged_in?
		!current_user.nil?
	end
end