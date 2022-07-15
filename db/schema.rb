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

ActiveRecord::Schema[7.0].define(version: 2022_07_15_203932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
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

  create_table "article_synchronisation_change_logs", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "synchronisation_event_id", null: false
    t.jsonb "changes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "article_on_sync_change_log_idx"
    t.index ["synchronisation_event_id"], name: "event_on_sync_change_log_idx"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "api_id"
    t.datetime "published_at", precision: nil
    t.jsonb "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_articles_on_api_id"
    t.index ["published_at"], name: "index_articles_on_published_at"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_likes_on_article_id"
  end

  create_table "synchronisation_events", force: :cascade do |t|
    t.datetime "last_checked_at", precision: nil
    t.datetime "completed_at", precision: nil
    t.datetime "errored_at", precision: nil
    t.jsonb "report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_at"], name: "index_synchronisation_events_on_completed_at"
    t.index ["errored_at"], name: "index_synchronisation_events_on_errored_at"
    t.index ["last_checked_at"], name: "index_synchronisation_events_on_last_checked_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "article_synchronisation_change_logs", "articles"
  add_foreign_key "article_synchronisation_change_logs", "synchronisation_events"
  add_foreign_key "likes", "articles"
end
