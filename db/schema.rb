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

ActiveRecord::Schema[6.1].define(version: 2021_02_07_194727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "entries", id: :uuid, default: -> { "uuid_generate_v1mc()" }, force: :cascade do |t|
    t.uuid "feed_id"
    t.jsonb "authors", default: []
    t.jsonb "contents"
    t.jsonb "contributors", default: []
    t.jsonb "description"
    t.jsonb "enclosures", default: []
    t.string "link", limit: 1023
    t.datetime "published_date"
    t.string "title", limit: 1023
    t.datetime "updated_date"
    t.string "url", limit: 1023
    t.string "uri", limit: 1023
    t.jsonb "readable_content"
    t.boolean "is_ready", default: false, null: false
    t.index ["published_date"], name: "entries_published_date_idx"
    t.index ["uri"], name: "entries_uri_idx"
  end

  create_table "feeds", id: :uuid, default: -> { "uuid_generate_v1mc()" }, force: :cascade do |t|
    t.jsonb "authors"
    t.jsonb "categories"
    t.jsonb "contributors"
    t.string "copyright", limit: 1023
    t.string "description", limit: 1023
    t.string "encoding", limit: 1023
    t.string "feed_type", limit: 1023
    t.string "image", limit: 1023
    t.string "language", limit: 1023
    t.string "link", limit: 1023
    t.jsonb "entry_links"
    t.datetime "published_date"
    t.string "title", limit: 1023
    t.string "uri", limit: 1023
    t.string "feed_uri", limit: 1023
    t.datetime "last_refreshed_at", default: -> { "now()" }, null: false
    t.string "type"
    t.string "scrape_index_news_element_selector"
    t.string "scrape_index_headline_selector"
    t.string "scrape_index_summary_selector"
    t.string "scrape_index_illustration_selector"
    t.string "scrape_index_illustration_attribute_name"
    t.string "scrape_index_link_selector"
    t.string "scrape_index_link_attribute_name"
    t.string "scrape_index_link_base"
    t.string "scrape_index_date_selector"
    t.string "scrape_index_date_format"
    t.string "scrape_index_author_selector"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v1mc()" }, force: :cascade do |t|
    t.string "token", limit: 255, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "users_token_idx", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "entries", "feeds", name: "entries_feed_id_fkey", on_delete: :cascade
end
