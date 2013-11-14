class Invite < ActiveRecord::Base
  include Tokenable

  belongs_to :user

  validates :new_user_email, presence: true
  validates_uniqueness_of :user_id, :scope => :new_user_email # can only invite someone once

end