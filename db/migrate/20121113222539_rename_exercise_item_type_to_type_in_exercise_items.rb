class RenameExerciseItemTypeToTypeInExerciseItems < ActiveRecord::Migration
  def change
    rename_column :exercise_items, :exercise_item_type, :type
  end
end
