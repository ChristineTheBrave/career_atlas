class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true
  validates :password_confirmation, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true
  has_many :saved_jobs
  has_many :jobs, through: :saved_jobs

  def secure_random
    self.authorization_token = SecureRandom.hex(64)
  end

  def logout
    self.authorization_token = SecureRandom.hex(64)
    self.save
  end

end
