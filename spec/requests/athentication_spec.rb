require 'rails_helper'

RSpec.describe "Authentication" do
  it 'return authorization token' do
    user_data = { name: 'user', email: 'peter@hotmail.com', password: 'password' }
    User.create(user_data);
    post '/api/v1/auth', :params => {user: {email: user_data[:email], password: user_data[:password]} }
    json_response = JSON.parse(response.body)
    expect(json_response).to have_key("name")
    expect(json_response).to have_key("token")
  end
end