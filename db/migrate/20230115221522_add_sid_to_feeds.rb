# typed: false
# frozen_string_literal: true

class AddSidToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :sid, :bigint, null: false, default: -> { 'generate_snowflake_id()' }
  end
end
