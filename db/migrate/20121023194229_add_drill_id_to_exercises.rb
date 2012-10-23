class AddDrillIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :drill_id, :integer
  end
end
