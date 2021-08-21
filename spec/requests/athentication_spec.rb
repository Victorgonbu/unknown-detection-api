require 'rails_helper'

RSpec.describe "Authentication" do
  it 'return authorization token' do
    user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
    user = User.create(user_data);
    post '/api/v1/auth', :params => {user: {email: user_data[:email], password: user_data[:password]} }
    expect(response_json).to have_key("name")
    expect(response_json).to have_key("token")
  end
end