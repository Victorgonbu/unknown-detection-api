# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'

user = User.new(name: FFaker::Name.first_name, email: FFaker::Internet.email, password: 'victor5', password_confirmation: 'victor5');

if user.save
  10.times do
    post = Post.create(
      title: FFaker::Movie.title,
      description: FFaker::Lorem.paragraph,
      location: FFaker::Address.country,
      user_id: user.id,
    )
    post.image.attach(io: File.open(File.join(Rails.root, 'app/assets/images/example.jpg')), filename: 'detection.jpg')
  end
end
