# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'



index = 1;
10.times do
  user = User.create(name: FFaker::Name.first_name, email: FFaker::Internet.email, password: 'victor5', password_confirmation: 'victor5');
  post = Post.create(
    title: FFaker::Movie.title,
    description: FFaker::Lorem.paragraph,
    location: FFaker::Address.city,
    user_id: user.id,
  )
  post.image.attach(io: File.open(File.join(Rails.root, "app/assets/images/post_#{index}.jpg")), filename: 'detection.jpg')
  index += 1
end
