json.profile do |json|
  json.partial! 'v1/profiles/user', profile: @user, current_user: @current_user
end