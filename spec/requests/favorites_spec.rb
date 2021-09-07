require 'rails_helper'

RSpec.describe 'Favorites' do
  before(:each) do
    user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass',
                  password_confirmation: 'victorpass' }
    @user = User.create(user_data)
    @post = Post.create(title: 'title', description: 'description', location: 'location', user_id: @user.id)
    Favorite.create(user_id: @user.id, post_id: @post.id)
  end
  describe 'GET index' do
    it 'returns current user favorite posts' do
      token = JsonWebToken.encode(sub: @user.id)
      get '/api/v1/favorites', headers: { Authorization: "Bearer #{token}" }
      expect(response_json['data'].size).to eq 1
      expect(response_json['data'][0]['id']).to eq @post.id.to_s
    end
    it 'returns error if no auth token is passed' do
      get '/api/v1/favorites'
      expect(response.status).to be(401)
      expect(response_json).to eq({ 'errors' => ['No current user'] })
    end
  end

  describe 'POST create' do
    it 'return favorite id and relationships' do
      token = JsonWebToken.encode(sub: @user.id)
      post '/api/v1/favorites', params: { favorite: { post_id: @post.id } },
                                headers: { Authorization: "Bearer #{token}" }
      expect(response_json['data']).to have_key('id')
      expect(response_json['data']).to have_key('relationships')
      expect(response.status).to be(200)
    end

    it 'return error if no auth token is passed' do
      post '/api/v1/favorites', params: { favorite: { post_id: @post.id } }
      expect(response.status).to be(401)
      expect(response_json).to eq({ 'errors' => ['No current user'] })
    end
  end

  describe 'DELETE destroy' do
    it 'return message when successfully deleted' do
      token = JsonWebToken.encode(sub: @user.id)
      favorite = Favorite.create(user_id: @user.id, post_id: @post.id)
      delete "/api/v1/favorites/#{favorite.id}", headers: { Authorization: "Bearer #{token}" }
      expect(response_json).to eq({ 'message' => 'Post deleted from favorites' })
      expect(response.status).to be(200)
    end

    it 'return error message when auth token is not passed' do
      favorite = Favorite.create(user_id: @user.id, post_id: @post.id)
      delete "/api/v1/favorites/#{favorite.id}"
      expect(response.status).to be(401)
      expect(response_json).to eq({ 'errors' => ['No current user'] })
    end
  end
end
