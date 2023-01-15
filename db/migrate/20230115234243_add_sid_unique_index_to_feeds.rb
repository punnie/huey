# typed: false
# frozen_string_literal: true

class AddSidUniqueIndexToFeeds < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :feeds, :sid, unique: true, algorithm: :concurrently
  end
end
