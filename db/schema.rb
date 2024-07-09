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

ActiveRecord::Schema[7.0].define(version: 2024_07_09_125340) do
  create_table "chat_transcripts", force: :cascade do |t|
    t.string "messaging_session_id"
    t.string "case_id"
    t.string "assigned_queue_name"
    t.string "assigned_officer"
    t.string "messaging_user"
    t.string "mop_phone_number"
    t.text "message"
    t.string "short_url"
    t.string "attachment"
    t.datetime "time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "contact_number"
    t.text "address"
    t.string "pincode"
    t.string "city"
    t.string "state"
    t.date "date_of_birth"
    t.date "date_of_hiring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

end
