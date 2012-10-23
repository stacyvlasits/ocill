class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "drills", "lessons", :name => "drills_lesson_id_fk"
    add_foreign_key "exercise_items", "exercises", :name => "exercise_items_exercise_id_fk"
    add_foreign_key "exercises", "drills", :name => "exercises_drill_id_fk"
    add_foreign_key "lessons", "courses", :name => "lessons_course_id_fk"
    add_foreign_key "media_items", "exercise_items", :name => "media_items_exercise_item_id_fk"
  end
end
