class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :poster_url
      t.string :small_cover_url
    end
  end
end
