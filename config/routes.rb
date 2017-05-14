Rails.application.routes.draw do
  
  scope :api, defaults: { format: :json }   do
    namespace :v1 do
  		post 'token' => 'user_token#create'
		resource :user, only: [:create, :show, :update, :destroy]
	end
  end 
end
