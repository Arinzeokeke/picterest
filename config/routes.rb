Rails.application.routes.draw do
  scope :api, defaults: { format: :json }   do
    namespace :v1 do
  		post 'token' => 'user_token#create'
		resource :user, only: [:create, :show, :update, :destroy]
		resources :profiles,  param: :username, only: [:index, :show] do
			member do
				get 'followers'
				get 'following'
			end
			resource :follow,  only: %i[create destroy]
		end
		resources :posts do
			collection do
				get 'feed'
				get 'liked'
			end
			resource :vote, only: [:create, :destroy]

		end
	end
  end 
end
