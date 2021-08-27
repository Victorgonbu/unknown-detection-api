class Post < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  belongs_to :author, class_name: "User", foreign_key: "user_id"
end
