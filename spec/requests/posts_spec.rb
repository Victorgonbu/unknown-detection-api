require 'rails_helper'

RSpec.describe 'Posts' do
  before(:all) do
    user_data = { name: 'user_name', email: 'peter2021@hotmail.com', password: 'victorpass', password_confirmation: 'victorpass' }
    User.create(user_data);
    Post.create(title: 'title', description: 'description', location: 'location', user_id: User.first.id)
    Post.create(title: 'post', description: 'description', location: 'location', user_id: User.first.id)
  end
  describe '.index' do
    it 'return all posts' do 
      get '/api/v1/posts'
      expect(response_json["data"].size).to eq 2
      expect(response_json.to_json).to eq PostSerializer.new(Post.all).serializable_hash.to_json 
    end

    describe 'search query' do 
      it 'return all posts where title matches' do 
        get '/api/v1/posts?search=title'
        expect(response_json["data"].size).to be 1
        expect(response_json.to_json).to eq PostSerializer.new([Post.first]).serializable_hash.to_json
      end
      it 'return error message if no matches found' do 
        get '/api/v1/posts?search=nomatches'
        expect(response_json).to eq({"errors" => ['No matches found']})
      end
    end  
  end

  describe '.show' do
    it 'return post data' do
      get '/api/v1/posts/1'
      expect(response_json.to_json).to eq PostSerializer.new(Post.first, {include: [:author]}).serializable_hash.to_json
    end
  end
end