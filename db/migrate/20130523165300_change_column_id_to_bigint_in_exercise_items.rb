class ChangeColumnIdToBigintInExerciseItems < ActiveRecord::Migration
  def up
    change_column :exercise_items, :id, 'bigint'
  end

  def down
    change_column :exercise_items, :id, :int
  end
end
