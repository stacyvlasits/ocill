class RemoveExerciseItemColumnFromHeader < ActiveRecord::Migration
  def up
    remove_column :headers, :exercise_item_id
  end

  def down
    add_column :headers, :exercise_item_id, :integer
  end
end
