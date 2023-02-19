class AddFeedSidToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :feed_sid, :bigint
  end
end
