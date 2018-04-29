class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+[a-z\d\-]\.[a-z]+\z/i },
      uniqueness: { case_sensitive: false }
  validates :password, presence: true, 
      length: { minimum: 6 }
  # validates :password_confirmation, presence: true
  has_secure_password
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
