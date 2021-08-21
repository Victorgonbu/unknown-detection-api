require 'rails_helper'

RSpec.describe "User" do
  describe '.create' do
    it 'create user and return hash with name and authorization token' do
      user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
      post '/api/v1/user', :params => {user: user_data }
      expect(response_json).to have_key("name")
      expect(response_json).to have_key("token")
    end
  end
end