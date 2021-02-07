# typed: false
# frozen_string_literal: true

class AddIsReadyToEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :is_ready, :boolean, null: false, default: false
  end
end
