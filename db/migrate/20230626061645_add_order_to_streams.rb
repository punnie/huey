class AddOrderToStreams < ActiveRecord::Migration[7.0]
  def change
    add_column :streams, :order, :integer, null: false, default: 0
  end
end
