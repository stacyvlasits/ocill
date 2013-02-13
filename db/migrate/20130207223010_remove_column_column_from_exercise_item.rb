class RemoveColumnColumnFromExerciseItem < ActiveRecord::Migration
  def up
    remove_column :exercise_items, :column
  end

  def down
    add_column :exercise_items, :column, :string
  end
end
