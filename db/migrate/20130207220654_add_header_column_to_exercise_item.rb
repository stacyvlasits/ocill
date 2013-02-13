class AddHeaderColumnToExerciseItem < ActiveRecord::Migration
  def change
    add_column :exercise_items, :header_id, :integer
  end
end
