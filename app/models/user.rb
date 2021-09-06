class User < ApplicationRecord
  REGEX = URI::MailTo::EMAIL_REGEXP
  include BCrypt
  validates :name, length: { in: 6..20 }, presence: true
  validates :password, confirmation: true, length: { minimum: 8 }, presence: true
  validates :password_confirmation, presence: true
  validates :email, format: { with: REGEX, message: 'Invalid email' }, 
  length: { minimum: 8 }, uniqueness: true, presence: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  def email_name
    email_name = email.split('@')
    email_name.first
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
