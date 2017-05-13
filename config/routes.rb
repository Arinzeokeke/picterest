Rails.application.routes.draw do
  
  scope :api, defaults: { format: :json } , constraints: { subdomain: 'api' }, path: '/'  do
    scope :v1, module: :v1 do
  		post 'token' => 'user_token#create'
		resource :user, only: [:create, :show, :update]
	end
  end 
end
