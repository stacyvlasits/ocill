class RemoveExerciseItemsPerExerciseFromDrills < ActiveRecord::Migration
  def up
    remove_column :drills, :exercise_items_per_exercise
  end

  def down
    add_column :drills, :exercise_items_per_exercise, :integer
  end
end
