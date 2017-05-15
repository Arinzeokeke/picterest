json.(profile, :id, :email, :name)
json.following profile.follow_count
json.followers profile.followers_count
if current_user (profile != current_user)
	json.you_follow profile.followed_by? current_user 
	json.follows_you current_user.followed_by? profile
end

