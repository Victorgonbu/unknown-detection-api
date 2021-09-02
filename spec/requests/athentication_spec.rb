require 'rails_helper'

RSpec.describe "Authentication" do
  describe 'create' do
    it 'return name, email, authorization token if valid credentials' do
      user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
      user = User.create(user_data);
      post '/api/v1/auth', :params => {user: {email: user_data[:email], password: user_data[:password]} }
      expect(response_json).to have_key("name")
      expect(response_json).to have_key("token")
      expect(response_json).to have_key("email")
      expect(response.status).to be(200)
    end
  
    it 'return errors array if invalid credentials' do
      post '/api/v1/auth', :params => {user: {email: 'email', password: 'password'} }
      expect(response.status).to be(404)
      expect(response_json).to eq({"errors" => ['Invalid email or password']})
    end
  end
end