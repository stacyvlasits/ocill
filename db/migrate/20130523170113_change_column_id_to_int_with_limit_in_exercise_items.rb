class ChangeColumnIdToIntWithLimitInExerciseItems < ActiveRecord::Migration
  def up
    change_column :exercise_items, :id, :int, :limit => 8
  end

  def down
    change_column :exercise_items, :id, 'bigint'
  end
end
