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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150721165555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "lti_resource_link_id", limit: 255
    t.integer  "section_id"
    t.integer  "drill_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "course_id"
  end

  add_index "activities", ["course_id"], name: "index_activities_on_course_id", using: :btree

  create_table "attempts", force: :cascade do |t|
    t.integer  "drill_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.string   "lis_outcome_service_url", limit: 255
    t.string   "lis_result_sourcedid",    limit: 255
    t.text     "response"
  end

  add_index "attempts", ["drill_id", "user_id"], name: "index_attempts_on_drill_id_and_user_id", using: :btree
  add_index "attempts", ["lis_result_sourcedid"], name: "index_attempts_on_lis_result_sourcedid", using: :btree
  add_index "attempts", ["user_id", "drill_id"], name: "index_attempts_on_user_id_and_drill_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "drills", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "prompt"
    t.text     "instructions"
    t.integer  "position"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "unit_id"
    t.text     "header_row"
    t.string   "type",         limit: 255
    t.text     "options"
  end

  add_index "drills", ["unit_id"], name: "index_drills_on_unit_id", using: :btree

  create_table "exercise_items", force: :cascade do |t|
    t.string   "text",               limit: 255
    t.boolean  "graded"
    t.string   "type",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "exercise_id"
    t.integer  "position"
    t.text     "acceptable_answers"
    t.string   "image",              limit: 255
    t.string   "audio",              limit: 255
    t.string   "video",              limit: 255
    t.integer  "header_id"
    t.text     "options"
    t.string   "panda_audio_id",     limit: 255
    t.datetime "deleted_at"
  end

  add_index "exercise_items", ["exercise_id"], name: "index_exercise_items_on_exercise_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.decimal  "weight"
    t.text     "prompt"
    t.integer  "position"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "drill_id"
    t.string   "audio",          limit: 255
    t.string   "video",          limit: 255
    t.string   "image",          limit: 255
    t.text     "options"
    t.string   "panda_audio_id", limit: 255
  end

  add_index "exercises", ["drill_id"], name: "index_exercises_on_drill_id", using: :btree

  create_table "headers", force: :cascade do |t|
    t.integer  "drill_id"
    t.string   "title",      limit: 255
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "headers", ["drill_id"], name: "index_headers_on_drill_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image",          limit: 255
    t.integer  "imageable_id"
    t.string   "imageable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "media_items", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "url",              limit: 255
    t.string   "type",             limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "exercise_item_id"
    t.string   "image",            limit: 255
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "exercise_item_id"
    t.integer  "attempt_id"
    t.text     "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "responses", ["attempt_id"], name: "index_responses_on_attempt_id", using: :btree
  add_index "responses", ["exercise_item_id"], name: "index_responses_on_exercise_item_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "course_id"
  end

  add_index "roles", ["course_id"], name: "index_roles_on_course_id", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "lti_course_id",    limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "canvas_course_id"
    t.string   "export_id",        limit: 255
    t.integer  "parent_id"
  end

  create_table "units", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "course_id"
  end

  add_index "units", ["course_id"], name: "index_units_on_course_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "eid",                    limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role",                   limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "lti_user_id",            limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "drills", "units", name: "drills_lesson_id_fk"
  add_foreign_key "drills", "units", name: "drills_unit_id_fk"
  add_foreign_key "exercise_items", "exercises", name: "exercise_items_exercise_id_fk"
  add_foreign_key "exercises", "drills", name: "exercises_drill_id_fk"
  add_foreign_key "media_items", "exercise_items", name: "media_items_exercise_item_id_fk"
  add_foreign_key "units", "courses", name: "lessons_course_id_fk"
end
