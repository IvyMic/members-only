class User < ApplicationRecord
  before_create :create_token_for_user
  before_save {self.email = email.downcase}
  validates :username, presence: true, length: {maximum: 50},
  uniqueness: {case_sensitive:false}

  validates :password, presence: true, length: {minimum: 8}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def create_token_for_user
    self.remember_token = User.digest(User.new_remember_token)
  end
end
