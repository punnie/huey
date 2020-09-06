class ImportLegacyDatabaseSchema < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'plpgsql'
    enable_extension 'uuid-ossp'

    create_table 'aggregations', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.string 'permalink', limit: 255, null: false
      t.datetime 'created_at', default: -> { 'now()' }, null: false
      t.string 'name', limit: 1023
      t.uuid 'user_id'
      t.index %w[permalink user_id], name: 'aggregations_permalink_user_id_idx', unique: true
    end

    create_table 'entries', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.uuid 'feed_id'
      t.jsonb 'authors'
      t.jsonb 'contents'
      t.jsonb 'contributors'
      t.jsonb 'description'
      t.jsonb 'enclosures'
      t.string 'link', limit: 1023
      t.datetime 'published_date'
      t.string 'title', limit: 1023
      t.datetime 'updated_date'
      t.string 'url', limit: 1023
      t.string 'uri', limit: 1023
      t.jsonb 'readable_content'
      t.index ['published_date'], name: 'entries_published_date_idx'
      t.index ['uri'], name: 'entries_uri_idx'
    end

    create_table 'feeds', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.jsonb 'authors'
      t.jsonb 'categories'
      t.jsonb 'contributors'
      t.string 'copyright', limit: 1023
      t.string 'description', limit: 1023
      t.string 'encoding', limit: 1023
      t.string 'feed_type', limit: 1023
      t.string 'image', limit: 1023
      t.string 'language', limit: 1023
      t.string 'link', limit: 1023
      t.jsonb 'entry_links'
      t.datetime 'published_date'
      t.string 'title', limit: 1023
      t.string 'uri', limit: 1023
      t.string 'feed_uri', limit: 1023
      t.datetime 'last_refreshed_at', default: -> { 'now()' }, null: false
    end

    create_table 'subscriptions', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.uuid 'aggregation_id'
      t.uuid 'feed_id'
    end

    create_table 'users', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.string 'username', limit: 255, null: false
      t.string 'password', limit: 255, null: false
      t.string 'token', limit: 255, null: false
      t.datetime 'created_at', default: -> { 'now()' }, null: false
      t.datetime 'updated_at', default: -> { 'now()' }, null: false
      t.index ['token'], name: 'users_token_idx', unique: true
      t.index ['username'], name: 'users_username_idx', unique: true
    end

    add_foreign_key 'aggregations', 'users', name: 'aggregations_user_id_fkey', on_delete: :cascade
    add_foreign_key 'entries', 'feeds', name: 'entries_feed_id_fkey', on_delete: :cascade
    add_foreign_key 'subscriptions', 'aggregations', name: 'subscriptions_aggregation_id_fkey', on_delete: :cascade
    add_foreign_key 'subscriptions', 'feeds', name: 'subscriptions_feed_id_fkey', on_delete: :cascade
  end
end
