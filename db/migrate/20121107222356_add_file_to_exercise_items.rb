class AddFileToExerciseItems < ActiveRecord::Migration
  def change
    add_column :exercise_items, :file, :string
  end
end
