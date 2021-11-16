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

ActiveRecord::Schema.define(version: 20211113012831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alergy_checks", force: :cascade do |t|
    t.date "worked_on", null: false
    t.string "note"
    t.boolean "first_check", default: false, null: false
    t.boolean "second_check", default: false, null: false
    t.boolean "student_check", default: false, null: false
    t.string "status"
    t.string "status_checker"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "menu", null: false
    t.string "support", null: false
    t.index ["student_id"], name: "index_alergy_checks_on_student_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_grade"
    t.string "second_grade"
    t.string "third_grade"
    t.string "fourth_grade"
    t.string "fifth_grade"
    t.string "sixth_grade"
    t.boolean "first_teacher", default: false
    t.boolean "second_teacher", default: false
    t.boolean "student", default: false
    t.string "status", default: "f"
    t.string "lunch_check_superior"
    t.boolean "superior_checker"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "class_name", default: "", null: false
    t.integer "class_grade"
    t.boolean "using_class", default: true
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_classrooms_on_school_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "menu_pdf"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_menus_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "school_name", default: "", null: false
    t.string "school_url", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "student_name", default: "", null: false
    t.integer "student_number", null: false
    t.bigint "school_id"
    t.bigint "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.string "teacher_of_student"
    t.string "student_classroom"
    t.string "alergy"
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "system_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_system_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_system_admins_on_reset_password_token", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "teacher_name", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "creator", default: false, null: false
    t.boolean "charger", default: false, null: false
    t.string "tcode", default: "", null: false
    t.bigint "school_id"
    t.bigint "classroom_id"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_teachers_on_classroom_id"
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "classroom"
    t.datetime "basic_time"
    t.datetime "work_time"
    t.boolean "superior", default: false
    t.string "department"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "alergy_checks", "students"
  add_foreign_key "attendances", "users"
  add_foreign_key "classrooms", "schools"
  add_foreign_key "menus", "schools"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "schools"
  add_foreign_key "teachers", "classrooms"
  add_foreign_key "teachers", "schools"
end
