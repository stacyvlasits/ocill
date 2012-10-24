class RemoveColumnNamesFromExercises < ActiveRecord::Migration
  def up
    remove_column :exercises, :column_names
  end

  def down
    add_column :exercises, :column_names, :text
  end
end
