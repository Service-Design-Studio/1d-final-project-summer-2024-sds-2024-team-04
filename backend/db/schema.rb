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

ActiveRecord::Schema[7.2].define(version: 2024_07_24_134456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ai_audited_scores", force: :cascade do |t|
    t.boolean "aiScore1"
    t.boolean "aiScore2"
    t.boolean "aiScore3"
    t.boolean "aiScore4"
    t.boolean "aiScore5"
    t.boolean "aiScore6"
    t.boolean "aiScore7"
    t.boolean "aiScore8"
    t.boolean "aiScore9"
    t.string "aiFeedback"
    t.float "totalScore"
    t.boolean "isMadeCorrection"
    t.bigint "case_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_ai_audited_scores_on_case_id"
  end

  create_table "cases", force: :cascade do |t|
    t.string "messagingSection"
    t.string "phoneNumber"
    t.string "topic"
    t.integer "status"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_cases_on_employee_id"
  end

  create_table "chat_transcripts", force: :cascade do |t|
    t.string "messagingUser"
    t.string "message"
    t.string "shortURL"
    t.string "attachmentURL"
    t.bigint "case_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_chat_transcripts_on_case_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_employees_on_role_id"
  end

  create_table "human_audited_scores", force: :cascade do |t|
    t.boolean "huScore1"
    t.boolean "huScore2"
    t.boolean "huScore3"
    t.boolean "huScore4"
    t.boolean "huScore5"
    t.boolean "huScore6"
    t.boolean "huScore7"
    t.boolean "huScore8"
    t.boolean "huScore9"
    t.string "huFeedback"
    t.float "huTotalScore"
    t.bigint "user_id", null: false
    t.bigint "ai_audited_score_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_audited_score_id"], name: "index_human_audited_scores_on_ai_audited_score_id"
    t.index ["user_id"], name: "index_human_audited_scores_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_users_on_employee_id"
  end

  add_foreign_key "ai_audited_scores", "cases"
  add_foreign_key "cases", "employees"
  add_foreign_key "chat_transcripts", "cases"
  add_foreign_key "employees", "roles"
  add_foreign_key "human_audited_scores", "ai_audited_scores"
  add_foreign_key "human_audited_scores", "users"
  add_foreign_key "users", "employees"
end
