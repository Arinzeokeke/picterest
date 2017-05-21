json.post do |json|
  json.partial! 'v1/posts/post',  post: @post
end