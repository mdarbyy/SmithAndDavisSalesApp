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

ActiveRecord::Schema[8.1].define(version: 2025_12_30_134816) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "sales_people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "first_name"
    t.boolean "is_active", default: true
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  create_table "sales_records", force: :cascade do |t|
    t.integer "amount_sold"
    t.datetime "created_at", null: false
    t.decimal "project_hours", default: "0.0"
    t.decimal "sales_floor_hours"
    t.bigint "sales_person_id", null: false
    t.date "sell_date"
    t.datetime "updated_at", null: false
    t.index ["sales_person_id"], name: "index_sales_records_on_sales_person_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.datetime "last_logged_in"
    t.string "last_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sales_records", "sales_people"
end
