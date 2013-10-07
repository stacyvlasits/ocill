class AddLessonIdToDrills < ActiveRecord::Migration
  def change
    add_column :drills, :lesson_id, :integer
  end
end
