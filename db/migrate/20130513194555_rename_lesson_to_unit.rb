class RenameLessonToUnit < ActiveRecord::Migration
  def change
    rename_table :lessons, :units
  end
end
