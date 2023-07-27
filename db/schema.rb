# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_27_054359) do
  create_table "appointments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string "comment"
    t.boolean "completed"
    t.integer "student_id", null: false
    t.integer "teacher_id", null: false
    t.index ["student_id", "teacher_id"], name: "index_appointments_on_student_id_and_teacher_id"
    t.index ["student_id"], name: "index_appointments_on_student_id"
    t.index ["teacher_id"], name: "index_appointments_on_teacher_id"
  end

  create_table "class_memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "subject_id", null: false
    t.index ["subject_id"], name: "index_class_memberships_on_subject_id"
    t.index ["user_id"], name: "index_class_memberships_on_user_id"
  end

  create_table "daily_emotions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "emotion_id", null: false
    t.integer "user_id", null: false
    t.index ["emotion_id"], name: "index_daily_emotions_on_emotion_id"
    t.index ["user_id"], name: "index_daily_emotions_on_user_id"
  end

  create_table "emotions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.integer "teacher_id", null: false
    t.integer "student_id", null: false
    t.index ["student_id", "teacher_id"], name: "index_notes_on_student_id_and_teacher_id"
    t.index ["student_id"], name: "index_notes_on_student_id"
    t.index ["teacher_id"], name: "index_notes_on_teacher_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "photo"
    t.string "room"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "users", column: "student_id"
  add_foreign_key "appointments", "users", column: "teacher_id"
  add_foreign_key "class_memberships", "subjects"
  add_foreign_key "class_memberships", "users"
  add_foreign_key "daily_emotions", "emotions"
  add_foreign_key "daily_emotions", "users"
  add_foreign_key "notes", "users", column: "student_id"
  add_foreign_key "notes", "users", column: "teacher_id"
  add_foreign_key "subjects", "users"
end
