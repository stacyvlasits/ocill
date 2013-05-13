class RenameLessonIdToUnitIDinDrills < ActiveRecord::Migration
  def change
    rename_column :drills, :lesson_id, :unit_id
  end
end
