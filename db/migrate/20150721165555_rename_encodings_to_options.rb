class RenameEncodingsToOptions < ActiveRecord::Migration
  def change
    rename_column :exercises, :encodings, :options
    rename_column :exercise_items, :encodings, :options
  end
end
