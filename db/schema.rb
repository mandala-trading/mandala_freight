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

ActiveRecord::Schema.define(version: 2022_09_12_132454) do

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "time_zone", limit: 50, default: "UTC", null: false
    t.integer "users_count", default: 0, null: false
    t.integer "countries_count", default: 0, null: false
    t.integer "currencies_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "short_name", limit: 20, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.datetime "discarded_at"
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_countries_on_account_id"
    t.index ["created_by_id"], name: "index_countries_on_created_by_id"
    t.index ["updated_by_id"], name: "index_countries_on_updated_by_id"
  end

  create_table "currencies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "code", default: "", null: false
    t.string "symbol", default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.datetime "discarded_at"
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_currencies_on_account_id"
    t.index ["created_by_id"], name: "index_currencies_on_created_by_id"
    t.index ["updated_by_id"], name: "index_currencies_on_updated_by_id"
  end

  create_table "page_settings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "module_name", limit: 250, null: false
    t.string "module_class", limit: 250, null: false
    t.integer "page_items", default: 20, null: false
    t.json "column_settings", null: false
    t.boolean "hide_deleted_records", default: true, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_page_settings_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name", limit: 250, default: "", null: false
    t.string "last_name", limit: 250, default: "", null: false
    t.string "email", limit: 250, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "active", default: true, null: false
    t.boolean "superadmin", default: false, null: false
    t.bigint "account_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "countries", "accounts"
  add_foreign_key "currencies", "accounts"
  add_foreign_key "page_settings", "users"
  add_foreign_key "users", "accounts"
end
