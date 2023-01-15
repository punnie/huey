# typed: false
# frozen_string_literal: true

class AddSidUniqueIndexToEntries < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :entries, :sid, unique: true, algorithm: :concurrently
  end
end
