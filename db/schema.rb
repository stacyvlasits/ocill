# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130912160431) do

  create_table "attempts", :force => true do |t|
    t.integer  "drill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "attempts", ["drill_id", "user_id"], :name => "index_attempts_on_drill_id_and_user_id"
  add_index "attempts", ["user_id", "drill_id"], :name => "index_attempts_on_user_id_and_drill_id"

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "drills", :force => true do |t|
    t.string   "title"
    t.text     "prompt"
    t.text     "instructions"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "unit_id"
    t.text     "header_row"
    t.string   "type"
    t.text     "options"
  end

  add_index "drills", ["unit_id"], :name => "index_drills_on_unit_id"

  create_table "exercise_items", :force => true do |t|
    t.string   "text"
    t.boolean  "graded"
    t.string   "type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "exercise_id"
    t.integer  "position"
    t.text     "acceptable_answers"
    t.string   "image"
    t.string   "audio"
    t.string   "video"
    t.integer  "header_id"
    t.text     "encodings"
    t.string   "panda_audio_id"
  end

  add_index "exercise_items", ["exercise_id"], :name => "index_exercise_items_on_exercise_id"

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.decimal  "weight"
    t.text     "prompt"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "drill_id"
    t.string   "audio"
    t.string   "video"
    t.string   "image"
    t.text     "encodings"
    t.string   "panda_audio_id"
  end

  add_index "exercises", ["drill_id"], :name => "index_exercises_on_drill_id"

  create_table "headers", :force => true do |t|
    t.integer  "drill_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "headers", ["drill_id"], :name => "index_headers_on_drill_id"

  create_table "images", :force => true do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "media_items", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "exercise_item_id"
    t.string   "image"
  end

  create_table "responses", :force => true do |t|
    t.integer  "exercise_item_id"
    t.integer  "attempt_id"
    t.text     "value"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "responses", ["attempt_id"], :name => "index_responses_on_attempt_id"
  add_index "responses", ["exercise_item_id"], :name => "index_responses_on_exercise_item_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "course_id"
  end

  add_index "roles", ["course_id"], :name => "index_roles_on_course_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "units", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  add_index "units", ["course_id"], :name => "index_units_on_course_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "eid"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "drills", "units", :name => "drills_lesson_id_fk"
  add_foreign_key "drills", "units", :name => "drills_unit_id_fk"

  add_foreign_key "exercise_items", "exercises", :name => "exercise_items_exercise_id_fk"

  add_foreign_key "exercises", "drills", :name => "exercises_drill_id_fk"

  add_foreign_key "media_items", "exercise_items", :name => "media_items_exercise_item_id_fk"

  add_foreign_key "units", "courses", :name => "lessons_course_id_fk"
  add_foreign_key "units", "courses", :name => "unit_course_id_fk"

end
