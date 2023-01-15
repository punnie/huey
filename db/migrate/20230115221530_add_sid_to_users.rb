# typed: false
# frozen_string_literal: true

class AddSidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sid, :bigint, null: false, default: -> { 'generate_snowflake_id()' }
  end
end
