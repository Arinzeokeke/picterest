json.profile do |json|
  json.partial! 'v1/profiles/user', locals: { profile: @user}
end