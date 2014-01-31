class RenameDeleteAtToDeletedAtInExerciseItem < ActiveRecord::Migration
  def up
    rename_column :exercise_items, :delete_at, :deleted_at
  end

  def down
    rename_column :exercise_items, :deleted_at, :delete_at
  end
end
