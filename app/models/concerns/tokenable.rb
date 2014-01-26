module Tokenable # extracted this logic to a concern, any model that includes tokenable can create a token now
  extend ActiveSupport::Concern
  
  included do
    before_create :generate_token
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
