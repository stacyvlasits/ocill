class AddCourseIdIndexToUnits < ActiveRecord::Migration
  def change
  	add_index :units, :course_id
  end
end
