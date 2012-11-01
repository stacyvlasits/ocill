class RenameAndCreateColumnsInExerciseItems < ActiveRecord::Migration
  def up
    rename_column :exercise_items, :scored, :graded
    add_column :exercise_items, :column, :string
    add_column :exercise_items, :answer, :string
  end

  def down
    rename_column :exercise_items, :graded, :scored
    remove_column :exercise_items, :column, :string
    remove_column :exercise_items, :answer, :string
  end
end
