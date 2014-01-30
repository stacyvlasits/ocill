class AddDeletedAtToExerciseItem < ActiveRecord::Migration
  def change
    add_column :exercise_items, :delete_at, :datetime
  end
end
