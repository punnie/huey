class AddUpdatedAtToAggregations < ActiveRecord::Migration[6.0]
  def change
    add_column :aggregations, :updated_at, :datetime, precision: 6, null: false, default: -> { 'now()' }
  end
end
