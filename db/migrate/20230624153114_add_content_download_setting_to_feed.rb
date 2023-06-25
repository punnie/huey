class AddContentDownloadSettingToFeed < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :download_content, :boolean, null: false, default: true
  end
end
