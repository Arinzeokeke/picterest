Rails.application.routes.draw do
  scope :api, defaults: { format: :json }   do
    namespace :v1 do
  		post 'token' => 'user_token#create'
		resource :user, only: [:create, :show, :update, :destroy]
		resources :profiles,  param: :username, only: [:index, :show] do
			resource :follow, only: %i[show create destroy]
		end
	end
  end 
end
