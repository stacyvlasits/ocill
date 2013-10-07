class ChangeForeignKeyNames < ActiveRecord::Migration
  def up
  	add_foreign_key "drills", "units", :name => "drills_unit_id_fk"
  end

  def down
  	add_foreign_key "drills", "lessons", :name => "drills_lesson_id_fk"
  end
end
