json.call(:post, :id, :title, :url, :created_at, :updated_at)
json.likes post.votes.up
if current_user
	json.liked current_user.voted_as_when_voted_for @comment1
end
json.author post.user, partial: 'v1/profiles/user', as: :profile


