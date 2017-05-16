require "rails_helper"
 
Rspec.describe 'Users API', type: :request do
	let!(:users) { create_list(:user, 2)}
	let(:user_name) {users.first.name}

	
end