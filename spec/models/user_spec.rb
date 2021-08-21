require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    describe 'name' do
      subject { described_class.new(email: 'peter@hotmail.com', password: 'password', password_confirmation: 'password') }
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
      
    end
  end
end