class ChangeForeignKeyNames < ActiveRecord::Migration
  def up
  	add_foreign_key "drills", "units", :name => "drills_unit_id_fk"
  	add_foreign_key "units", "courses", :name => "unit_course_id_fk"
  	execute 'ALTER TABLE drills DROP FOREIGN KEY drills_lesson_id_fk'
  	execute 'ALTER TABLE units DROP FOREIGN KEY lessons_course_id_fk'
  end

  def down
  	add_foreign_key "drills", "lessons", :name => "drills_lesson_id_fk"
  	add_foreign_key "lessons", "courses", :name => "lessons_course_id_fk"
  	execute 'ALTER TABLE drills DROP FOREIGN KEY drills_unit_id_fk'
  	execute 'ALTER TABLE units DROP FOREIGN KEY unit_course_id_fk'
  end
end
