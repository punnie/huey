# frozen_string_literal: true

class RemoveUsernameAndPasswordFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :username, :string
    remove_column :users, :password, :string
  end
end
