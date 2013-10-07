class AddOrderToExerciseItems < ActiveRecord::Migration
  def change
    add_column :exercise_items, :order, :integer
  end
end
