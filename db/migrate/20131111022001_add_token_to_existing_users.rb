class AddTokenToExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.generate_token
      user.save
    end
  end
end
