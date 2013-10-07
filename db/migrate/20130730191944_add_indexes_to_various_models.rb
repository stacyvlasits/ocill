class AddIndexesToVariousModels < ActiveRecord::Migration
  def change
  	add_index :drills, :unit_id
  	add_index :exercises, :drill_id
  	add_index :exercise_items, :exercise_id
  	add_index :headers, :drill_id
  	add_index :responses, :exercise_item_id
  	add_index :responses, :attempt_id
  	add_index :roles, :user_id
  	add_index :roles, :course_id
  	add_index :attempts, [:drill_id, :user_id]
  	add_index :attempts, [:user_id, :drill_id]
  end
end
