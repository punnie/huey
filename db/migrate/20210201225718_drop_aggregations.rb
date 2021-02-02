# typed: false
# frozen_string_literal: true

class DropAggregations < ActiveRecord::Migration[6.0]
  def change
    drop_table :aggregations
  end
end
