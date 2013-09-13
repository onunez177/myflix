class User < ActiveRecord::Base
  has_many :reviews
  
  has_secure_password validations: false # turning off bcrypt ruby validations and let us set our own validations

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
    
end