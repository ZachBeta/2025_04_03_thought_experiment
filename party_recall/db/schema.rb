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

ActiveRecord::Schema[8.0].define(version: 2025_04_03_130343) do
  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.integer "token_count", default: 0, null: false
    t.string "message_type", null: false
    t.integer "position", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_messages_on_active"
    t.index ["message_type"], name: "index_messages_on_message_type"
    t.index ["position"], name: "index_messages_on_position"
  end

  create_table "tutorial_progresses", force: :cascade do |t|
    t.string "current_stage", null: false
    t.json "completed_steps", default: {}, null: false
    t.string "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_stage"], name: "index_tutorial_progresses_on_current_stage"
    t.index ["session_id"], name: "index_tutorial_progresses_on_session_id", unique: true
  end
end
