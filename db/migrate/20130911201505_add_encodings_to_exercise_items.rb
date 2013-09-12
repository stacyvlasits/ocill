class AddEncodingsToExerciseItems < ActiveRecord::Migration
  def change
    add_column :exercise_items, :encodings, :text
  end
end
