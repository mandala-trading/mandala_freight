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

ActiveRecord::Schema.define(version: 2022_09_26_075316) do

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "time_zone", limit: 50, default: "UTC", null: false
    t.integer "users_count", default: 0, null: false
    t.integer "countries_count", default: 0, null: false
    t.integer "currencies_count", default: 0, null: false
    t.integer "buyers_count", default: 0, null: false
    t.integer "container_details_count", default: 0, null: false
    t.integer "shipping_lines_count", default: 0, null: false
    t.integer "freight_items_count", default: 0, null: false
    t.integer "units_count", default: 0, null: false
    t.integer "payment_types_count", default: 0, null: false
    t.integer "charge_types_count", default: 0, null: false
    t.integer "ports_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buyers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "short_name", limit: 50, default: "", null: false
    t.string "street_address", limit: 250, default: "", null: false
    t.string "city", limit: 250, default: "", null: false
    t.string "state", limit: 250, default: "", null: false
    t.string "zip_code", limit: 50, default: "", null: false
    t.column "risk_profile", "enum('no_risk','high_risk','medium_risk','low_risk')", default: "no_risk"
    t.text "remarks"
    t.boolean "archived", default: false, null: false
    t.bigint "country_id", null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_buyers_on_account_id"
    t.index ["country_id"], name: "index_buyers_on_country_id"
    t.index ["created_by_id"], name: "index_buyers_on_created_by_id"
    t.index ["updated_by_id"], name: "index_buyers_on_updated_by_id"
  end

  create_table "charge_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_charge_types_on_account_id"
    t.index ["created_by_id"], name: "index_charge_types_on_created_by_id"
    t.index ["updated_by_id"], name: "index_charge_types_on_updated_by_id"
  end

  create_table "container_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "description", limit: 250, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_container_details_on_account_id"
    t.index ["created_by_id"], name: "index_container_details_on_created_by_id"
    t.index ["updated_by_id"], name: "index_container_details_on_updated_by_id"
  end

  create_table "countries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "short_name", limit: 20, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_countries_on_account_id"
    t.index ["created_by_id"], name: "index_countries_on_created_by_id"
    t.index ["updated_by_id"], name: "index_countries_on_updated_by_id"
  end

  create_table "currencies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "code", limit: 20, default: "", null: false
    t.string "symbol", limit: 20, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_currencies_on_account_id"
    t.index ["created_by_id"], name: "index_currencies_on_created_by_id"
    t.index ["updated_by_id"], name: "index_currencies_on_updated_by_id"
  end

  create_table "filter_options", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "module_name", limit: 250, null: false
    t.string "module_class", limit: 250, null: false
    t.json "filters", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_filter_options_on_user_id"
  end

  create_table "freight_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_freight_items_on_account_id"
    t.index ["created_by_id"], name: "index_freight_items_on_created_by_id"
    t.index ["updated_by_id"], name: "index_freight_items_on_updated_by_id"
  end

  create_table "page_settings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "module_name", limit: 250, null: false
    t.string "module_class", limit: 250, null: false
    t.integer "page_items", default: 20, null: false
    t.json "column_settings", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_page_settings_on_user_id"
  end

  create_table "payment_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_payment_types_on_account_id"
    t.index ["created_by_id"], name: "index_payment_types_on_created_by_id"
    t.index ["updated_by_id"], name: "index_payment_types_on_updated_by_id"
  end

  create_table "ports", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "city", limit: 250, null: false
    t.boolean "loading_port", default: false, null: false
    t.boolean "transhipment_port", default: false, null: false
    t.boolean "discharge_port", default: false, null: false
    t.boolean "delivery_port", default: false, null: false
    t.boolean "archived", default: false, null: false
    t.bigint "country_id", null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_ports_on_account_id"
    t.index ["country_id"], name: "index_ports_on_country_id"
    t.index ["created_by_id"], name: "index_ports_on_created_by_id"
    t.index ["updated_by_id"], name: "index_ports_on_updated_by_id"
  end

  create_table "shipping_lines", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.string "short_name", limit: 50, default: "", null: false
    t.string "street_address", limit: 250, default: "", null: false
    t.string "city", limit: 250, default: "", null: false
    t.string "state", limit: 250, default: "", null: false
    t.string "zip_code", limit: 50, default: "", null: false
    t.column "risk_profile", "enum('no_risk','high_risk','medium_risk','low_risk')", default: "no_risk"
    t.text "remarks"
    t.boolean "archived", default: false, null: false
    t.bigint "country_id", null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_shipping_lines_on_account_id"
    t.index ["country_id"], name: "index_shipping_lines_on_country_id"
    t.index ["created_by_id"], name: "index_shipping_lines_on_created_by_id"
    t.index ["updated_by_id"], name: "index_shipping_lines_on_updated_by_id"
  end

  create_table "units", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 250, default: "", null: false
    t.boolean "container_type", default: false, null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_units_on_account_id"
    t.index ["created_by_id"], name: "index_units_on_created_by_id"
    t.index ["updated_by_id"], name: "index_units_on_updated_by_id"
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

  add_foreign_key "buyers", "accounts"
  add_foreign_key "buyers", "countries"
  add_foreign_key "charge_types", "accounts"
  add_foreign_key "container_details", "accounts"
  add_foreign_key "countries", "accounts"
  add_foreign_key "currencies", "accounts"
  add_foreign_key "filter_options", "users"
  add_foreign_key "freight_items", "accounts"
  add_foreign_key "page_settings", "users"
  add_foreign_key "payment_types", "accounts"
  add_foreign_key "ports", "accounts"
  add_foreign_key "ports", "countries"
  add_foreign_key "shipping_lines", "accounts"
  add_foreign_key "shipping_lines", "countries"
  add_foreign_key "units", "accounts"
  add_foreign_key "users", "accounts"
end
