class Relationship < ActiveRecord::Base

  belongs_to :user
  belongs_to :following, :class_name => 'User'

  validates_uniqueness_of :user_id, scope: => :following_id # can only follow someone once

end