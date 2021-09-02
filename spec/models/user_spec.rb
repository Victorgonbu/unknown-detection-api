require 'rails_helper'

RSpec.describe User do
  subject do
    described_class.create(name: 'victor', email: 'peter@hotmail.com', password: 'password',
                           password_confirmation: 'password')
  end
  describe 'validations' do
    describe 'name' do
      subject do
        described_class.new(email: 'peter@hotmail.com', password: 'password', password_confirmation: 'password')
      end
      it 'must be present' do
        expect(subject).to_not be_valid
        subject.name = 'Victor'
        expect(subject).to be_valid
      end

      it 'must contain more than 6 and less than 20 characters' do
        subject.name = 'vic'
        expect(subject).to_not be_valid
        subject.name = 'name larger than 20 characters'
        expect(subject).to_not be_valid
        subject.name = 'valid name'
        expect(subject).to be_valid
      end
    end

    describe 'email' do
      subject { described_class.new(name: 'Victor', password: 'Victor', password_confirmation: 'Victor') }
      it 'must be present' do
        expect(subject).to be_invalid
        subject.email = 'peter@hotmail.com'
        expect(subject).to be_valid
      end
      it 'must be unique' do
        subject.email = 'peter@hotmail.com'
        expect(subject).to be_valid
        subject.save
        no_unique = described_class.new(name: 'Manuel', password: 'password', password_confirmation: 'password')
        no_unique.email = subject.email
        expect(no_unique).to_not be_valid
      end

      it 'must match regex expression' do
        subject.email = 'peter@hotmail..com'
        expect(subject).to_not be_valid
        subject.email = 'peter@@hotmail.com'
        expect(subject).to_not be_valid
        subject.email = 'peter@hotmail.com'
        expect(subject).to be_valid
      end

      it 'must be at least 8 characters long' do
        subject.email = 'a@a.com'
        expect(subject).to be_invalid
        subject.email = 'peter@hotmail.com'
        expect(subject).to be_valid
      end
    end

    describe 'password & password_confirmation' do
      subject { described_class.new(name: 'Victor', email: 'peter@hotmail.com') }
      it 'must be present' do
        subject.password = ''
        subject.password_confirmation = ''
        expect(subject).to_not be_valid
        subject.password = 'valid_password'
        subject.password_confirmation = 'valid_password'
        expect(subject).to be_valid
      end

      it 'must have confirmation' do
        subject.password = 'password'
        expect(subject).to_not be_valid
        subject.password_confirmation = 'password'
        expect(subject).to be_valid
      end

      it 'must match confitmation' do
        subject.password = 'password'
        subject.password_confirmation = 'passwordd'
        expect(subject).to_not be_valid
        subject.password_confirmation = 'password'
        expect(subject).to be_valid
      end
    end
  end

  describe 'associations' do
    it 'has many favorites' do
      relation = described_class.reflect_on_association(:favorites)
      expect(relation.macro).to eq :has_many
    end
    it 'has many favorite posts' do
      relation = described_class.reflect_on_association(:favorite_posts)
      expect(relation.macro).to eq :has_many
    end
  end

  describe '#email_name' do
    it "returns the first part before '@' from user email" do
      expect(subject.email_name).to eq 'peter'
    end
  end

  describe '#password' do
    it 'returns encrypted password using BCrypt' do
      expect(subject.password.class).to eq BCrypt::Password
    end
  end

  describe '#password=' do
    it 'Assign encrypted password to password_hash record field' do
      subject.password = 'password'
      expect(subject.password_hash).to be_truthy
    end
  end
end
