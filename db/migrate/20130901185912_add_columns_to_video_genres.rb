class AddColumnsToVideoGenres < ActiveRecord::Migration
  def change
    add_column :video_genres, :video_id, :integer
    add_column :video_genres, :genre_id, :integer
  end
end
