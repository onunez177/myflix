class User < ActiveRecord::Base
  include Tokenable #../models/concerns
  
  has_many :reviews
  has_many :invites
  
  has_many :queued_videos
  has_many :videos, through: :queued_videos
  
  has_many :relationships # this class is used to setup our social networking feature
  has_many :following, through: :relationships # this will allow us to do user.following to pull all the people they are following
  has_many :followers, foreign_key: :following_id, class_name: "Relationship" # we can now do user.followers 
  
  has_secure_password validations: false # turning off bcrypt ruby validations and let us set our own validations

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 5}
  
    
  def normalize_queue 
    queued_videos.each_with_index do |queue_item, index| # the each with index method replaces the need for a counter/index within the loop
      queue_item.update_attributes(queue_position: index+1) # update_attributes method
    end
  end
  
  def deactivate!
    update_column(:active, false)
  end
end