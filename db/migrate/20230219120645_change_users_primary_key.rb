class ChangeUsersPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :id
      t.rename :sid, :id
    end

    execute 'ALTER TABLE users ADD PRIMARY KEY (id)'
  end
end
