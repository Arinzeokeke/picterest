json.posts @posts, partial: 'v1/posts/post', locals: {current_user: nil}, as: :post
json.count @posts.size