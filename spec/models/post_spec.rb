require 'rails_helper'

RSpec.describe Post do
  describe 'validations' do
    describe 'title' do
      User.create(name: 'victor', email: 'author3@hotmail.com', password: 'password', password_confirmation: 'password')
      subject {described_class.new(description: 'description', location: 'location', user_id: User.last.id)}
      it 'must be present' do
        expect(subject).to_not be_valid
        subject.title = 'post title2'
        expect(subject).to be_valid
        subject.save
      end

      it 'must be unique' do
        subject {described_class.new(title: 'post title', description: 'description', location: 'location', user_id: User.last.id)}
        expect(subject).to_not be_valid
        subject.title = 'new title'
        expect(subject).to be_valid
      end
      
    end
  end

  describe 'associations' do
    it 'has many favorites' do
      relation = described_class.reflect_on_association(:favorites);
      expect(relation.macro).to eq :has_many
    end
    it 'belongs to author' do
      relation = described_class.reflect_on_association(:author);
      expect(relation.macro).to eq :belongs_to
    end
  end

  describe '.search' do
    it 'returns ActviveRecord::Relation of posts where title matches query' do
      expect(described_class.search('title')[0].id).to eq 9;

    end
  end
end