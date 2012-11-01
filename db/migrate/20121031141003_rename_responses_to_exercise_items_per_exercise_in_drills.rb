class RenameResponsesToExerciseItemsPerExerciseInDrills < ActiveRecord::Migration
  def change
    rename_column :drills, :responses, :exercise_items_per_exercise  
  end
end
