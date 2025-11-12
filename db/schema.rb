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

ActiveRecord::Schema[7.0].define(version: 2025_11_12_204356) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sales_people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_active", default: true
  end

  create_table "sales_records", force: :cascade do |t|
    t.date "sell_date"
    t.integer "amount_sold"
    t.integer "items_sold"
    t.decimal "sales_floor_hours"
    t.decimal "project_hours", default: "0.0"
    t.bigint "sales_person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_person_id"], name: "index_sales_records_on_sales_person_id"
  end

  add_foreign_key "sales_records", "sales_people"
end
