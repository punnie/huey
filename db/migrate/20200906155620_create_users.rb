# typed: false
# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table 'users', id: :uuid, default: -> { 'uuid_generate_v1mc()' }, force: :cascade do |t|
      t.string 'username', limit: 255, null: false
      t.string 'password', limit: 255, null: false
      t.string 'token', limit: 255, null: false
      t.datetime 'created_at', default: -> { 'now()' }, null: false
      t.datetime 'updated_at', default: -> { 'now()' }, null: false
      t.index ['token'], name: 'users_token_idx', unique: true
      t.index ['username'], name: 'users_username_idx', unique: true
    end
  end
end
