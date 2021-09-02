require 'rails_helper'

RSpec.describe "User" do
  describe '.create' do
    it 'create user and return hash with name and authorization token' do
      user_data = { name: 'user_name', email: 'peter20211@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
      post '/api/v1/users', :params => {user: user_data }
      expect(response_json).to have_key("name")
      expect(response_json).to have_key("token")
      expect(response_json).to have_key("email")
      expect(response.status).to be(200)
    end
    it 'renturn array with errors if invalid input fields' do
      user_data = { name: 'name', email: 'peter20211@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
      post '/api/v1/users', :params => {user: user_data }
      expect(response.status).to be(404)
      expect(response_json).to eq({"errors" => ['Name is too short (minimum is 6 characters)']})
      user_data[:password] = 'none'
      post '/api/v1/users', :params => {user: user_data }
      expect(response_json).to eq({"errors" => ["Password confirmation doesn't match Password", "Name is too short (minimum is 6 characters)"]})
    end
  end
end