class Invite < ActiveRecord::Base
  include Tokenable

  belongs_to :user

end