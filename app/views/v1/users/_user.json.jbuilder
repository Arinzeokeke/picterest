json.(user, :id, :email, :name)
json.following user.follow_count
json.followers user.followers_count
if @current_user && (user != @current_user)
	json.you_follow user.followed_by? @current_user 
	json.follows_you @current_user.followed_by? user
end