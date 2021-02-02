class AddTypeToFeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :type, :string
  end
end
