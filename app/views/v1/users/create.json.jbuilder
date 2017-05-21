json.user do |json|
  json.partial! 'v1/users/user', user: @user, current_user: nil
end