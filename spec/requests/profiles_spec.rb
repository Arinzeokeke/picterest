require "rails_helper"

RSpec.describe "User management", :type => :request do

  it "creates a valid User and returns the user object" do
    headers = {
      "ACCEPT" => "application/json"
    }
    post v1_user_path, params: { user: {name: 'johnny', email: 'faker@faker.com', password: 'willow'} }, :headers => headers
    expect(response.body).to include("johnny")
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)

  end

  it 'returns an error json for an invalid user' do
    headers = {
      "ACCEPT" => "application/json"
    }
    post v1_user_path, params: { user: {name: 'johnny', email: 'fakerfaker.com', password: 'willow'} }, :headers => headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'returns a token when requested' do

    User.create(:post, email: 'king@william.com', password: 'william')
    headers = {
      "ACCEPT" => "application/json"
    }

    post v1_token_path, params: { { email: 'king@william.com', password: 'william'} }, :headers => headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)

  end
  it "updates a valid User and requires token" do
    test_user = User.create!(name: 'peter', email: 'peter@peter.com', password: 'peter')
    headers = {
      "ACCEPT" => "application/json"
    }
    post v1_token_path, params: { { email: 'peter@peter.com', password: 'peter'} }, :headers => headers

    token = response.body.token

    headers = {
      "ACCEPT" => "application/json",
      "AUTHORISATION" => token
    }
    put v1_user_path, params: { user: {name: 'johnny', email: 'faker@faker.com'} }, :headers => headers
    expect(response.body).to include("johnny")
    expect(response.content_type).to eq("application/json")
    #expect(response).to have_http_status(:created)

  end
 

  it "destroys a user" do
    delete v1_user_path
    expect(response.body).to include("user deleted")
  end
end