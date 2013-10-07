class RemoveFileFromExerciseItems < ActiveRecord::Migration
  def up
    remove_column :exercise_items, :file
  end

  def down
    add_column :exercise_items, :file, :string
  end
end
