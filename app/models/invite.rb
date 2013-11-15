class Invite < ActiveRecord::Base
  include Tokenable

  belongs_to :user
  validates :new_user_email, presence: true

end