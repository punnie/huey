class ChangeEntriesPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    change_table :entries do |t|
      t.remove :id
      t.rename :sid, :id
    end

    execute 'ALTER TABLE entries ADD PRIMARY KEY (id)'
  end
end
