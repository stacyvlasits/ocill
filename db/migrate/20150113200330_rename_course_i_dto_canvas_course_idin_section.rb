class RenameCourseIDtoCanvasCourseIdinSection < ActiveRecord::Migration
  def change
    rename_column :sections, :course_id, :canvas_course_id    
  end
end
