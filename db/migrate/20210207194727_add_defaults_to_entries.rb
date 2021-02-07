# typed: false
# frozen_string_literal: true

class AddDefaultsToEntries < ActiveRecord::Migration[6.0]
  def change
    change_column_default :entries, :authors, from: nil, to: []
    change_column_default :entries, :contributors, from: nil, to: []
    change_column_default :entries, :enclosures, from: nil, to: []
  end
end
