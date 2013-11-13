class CreateInvitesTable < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.string  :new_user_email
      t.string  :token
      
      t.timestamps
    end
  end
end
