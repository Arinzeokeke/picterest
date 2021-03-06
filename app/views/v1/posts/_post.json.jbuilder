json.call(post, :id, :title, :url, :created_at, :updated_at)
json.likes post.votes_for.up.size
json.slug post.friendly_id
if @current_user
	json.liked @current_user.voted_as_when_voted_for(post) || false
end
json.tags post.tag_list
json.author do

	json.partial! partial: 'v1/profiles/user',  locals: { profile: post.user }
end


