class User < ApplicationRecord
    REGEX = URI::MailTo::EMAIL_REGEXP
    include BCrypt
    has_many :favorites
    validates :name, :email, :password, :password_confirmation, presence: true
    validates :password, confirmation: true
    validates :email, format: { with: REGEX, message: "Invalid email"}
    validates :name, length: { in: 6..20 }
    validates :email, :password, length: { minimum: 8 }
    validates :email, uniqueness: true
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post

    def email_name
      email_name = self.email.split("@")
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
