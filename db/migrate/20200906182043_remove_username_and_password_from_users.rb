class RemoveUsernameAndPasswordFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :username
    remove_column :users, :password
  end
end
