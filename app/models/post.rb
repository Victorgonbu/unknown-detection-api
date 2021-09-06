class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  scope :search, ->(query) { where('lower(title) LIKE ?', "%#{query}%") }
  scope :all_posts, ->() { includes(:favorites, image_attachment: :blob) }
end
