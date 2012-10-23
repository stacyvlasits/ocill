class AddExerciseIdToExerciseItems < ActiveRecord::Migration
  def change
    add_column :exercise_items, :exercise_id, :integer
  end
end
