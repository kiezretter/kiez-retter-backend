# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_03_160200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "business_imports", force: :cascade do |t|
    t.text "content"
    t.datetime "imported_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "import_error"
    t.integer "business_count"
  end

  create_table "business_types", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string "gmap_id"
    t.string "name"
    t.float "lat"
    t.float "lng"
    t.boolean "verified"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.string "street_address"
    t.string "postcode"
    t.string "city"
    t.text "personal_message"
    t.text "personal_thank_you"
    t.bigint "business_type_id", null: false
    t.bigint "business_import_id"
    t.index ["business_import_id"], name: "index_businesses_on_business_import_id"
    t.index ["business_type_id"], name: "index_businesses_on_business_type_id"
    t.index ["lat", "lng"], name: "index_businesses_on_lat_lng"
  end

  create_table "dead_links", force: :cascade do |t|
    t.bigint "funding_id", null: false
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "error_msg"
    t.index ["funding_id"], name: "index_dead_links_on_funding_id"
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.integer "amount_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_donations_on_business_id"
  end

  create_table "fundings", force: :cascade do |t|
    t.string "link"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "funding_type"
    t.index ["business_id"], name: "index_fundings_on_business_id"
  end

  create_table "image_references", force: :cascade do |t|
    t.string "google_reference"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_image_references_on_business_id"
  end

  create_table "owners", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.string "email"
    t.string "paypal_handle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nick_name"
    t.string "salutation"
    t.string "last_name"
    t.string "first_name"
    t.index ["business_id"], name: "index_owners_on_business_id"
  end

  create_table "passports", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_passports_on_owner_id"
  end

  create_table "trackings", force: :cascade do |t|
    t.bigint "business_id"
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_trackings_on_business_id"
  end

  create_table "trade_certificates", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_trade_certificates_on_business_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "businesses", "business_imports"
  add_foreign_key "businesses", "business_types"
  add_foreign_key "dead_links", "fundings"
  add_foreign_key "donations", "businesses"
  add_foreign_key "fundings", "businesses"
  add_foreign_key "image_references", "businesses"
  add_foreign_key "owners", "businesses"
  add_foreign_key "passports", "owners"
  add_foreign_key "trackings", "businesses"
end
