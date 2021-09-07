require 'rails_helper'

RSpec.describe 'Authentication' do
  describe 'POST create' do
    it 'return name, email, authorization token if valid credentials' do
      user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass',
                    password_confirmation: 'victorpass' }
      User.create(user_data)
      post '/api/v1/authentication', params: { user: { email: user_data[:email], password: user_data[:password] } }
      expect(response_json["data"]["attributes"]).to have_key('name')
      expect(response_json["data"]["attributes"]).to have_key('token')
      expect(response_json["data"]["attributes"]).to have_key('email_name')
      expect(response.status).to be(200)
    end

    it 'return errors array if invalid credentials' do
      post '/api/v1/authentication', params: { user: { email: 'email', password: 'password' } }
      expect(response.status).to be(422)
      expect(response_json).to eq({ 'errors' => ['Invalid email or password'] })
    end
  end
end
