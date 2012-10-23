class RenameTypeToExerciseItemTypeInExerciseItems < ActiveRecord::Migration
  def up
    rename_column :exercise_items, :type, :exercise_item_type
  end

  def down
    rename_column :exercise_items, :exercise_item_type, :type
  end
end
