json.post do |json|
  json.partial! 'v1/posts/post', current_user: nil,  post: @post
end