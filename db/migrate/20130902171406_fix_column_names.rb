class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :genres, :genre, :name
  end
end
