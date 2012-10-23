class AddExerciseItemIdToMediaItems < ActiveRecord::Migration
  def change
    add_column :media_items, :exercise_item_id, :integer
  end
end
