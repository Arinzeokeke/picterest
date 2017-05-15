json.call(:post, :id, :title, :url, :created_at, :updated_at)
json.author post.user, partial: 'v1/profiles/user', as: :profile


