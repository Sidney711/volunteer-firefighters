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

ActiveRecord::Schema[7.1].define(version: 2024_04_02_152637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "account_awards", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "award_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_awards_on_account_id"
    t.index ["award_id"], name: "index_account_awards_on_award_id"
  end

  create_table "account_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.citext "email", null: false
    t.string "password_hash"
    t.string "full_name"
    t.date "birth_date"
    t.string "permament_address"
    t.string "phone"
    t.string "member_code"
    t.boolean "is_super_admin", default: false, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
    t.index ["member_code"], name: "index_accounts_on_member_code", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "awards", force: :cascade do |t|
    t.string "name", null: false
    t.integer "award_type", null: false
    t.integer "dependent_award_id"
    t.integer "minimum_service_years", default: 0
    t.integer "minimum_age", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.bigint "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_districts_on_code", unique: true
    t.index ["region_id"], name: "index_districts_on_region_id"
  end

  create_table "fire_departments", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.bigint "district_id", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_fire_departments_on_code", unique: true
    t.index ["district_id"], name: "index_fire_departments_on_district_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.date "start_date"
    t.bigint "fire_department_id"
    t.bigint "account_id", null: false
    t.integer "role", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["fire_department_id"], name: "index_memberships_on_fire_department_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_regions_on_code", unique: true
  end

  add_foreign_key "account_awards", "accounts"
  add_foreign_key "account_awards", "awards"
  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "districts", "regions"
  add_foreign_key "fire_departments", "districts"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "fire_departments"
end
