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

ActiveRecord::Schema[7.0].define(version: 2024_07_08_145417) do
  create_table "chat_transcripts", force: :cascade do |t|
    t.integer "chat_id"
    t.integer "messaging_section_id"
    t.integer "case_id"
    t.integer "assigned_officer_id"
    t.string "messaging_user"
    t.integer "MOP_phone_number"
    t.text "message"
    t.string "short_url"
    t.string "attachment_type"
    t.integer "attachment_id"
    t.text "topic"
    t.time "datetime"
    t.boolean "isAudited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachment_type", "attachment_id"], name: "index_chat_transcripts_on_attachment"
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
