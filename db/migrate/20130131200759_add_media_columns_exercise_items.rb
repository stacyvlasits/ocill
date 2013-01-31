class AddMediaColumnsExerciseItems < ActiveRecord::Migration
  def up
    add_column :exercise_items, :image, :string
    add_column :exercise_items, :audio, :string
    add_column :exercise_items, :video, :string
  end

  def down
    remove_column :exercise_items, :image
    remove_column :exercise_items, :audio
    remove_column :exercise_items, :video
  end
end
