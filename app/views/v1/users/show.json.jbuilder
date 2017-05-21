json.user do |json|
  json.partial! 'v1/users/user', user: @current_user, current_user: @current_user
end