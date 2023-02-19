class ChangeEntriesPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    execute 'ALTER TABLE entries DROP CONSTRAINT entries_pkey'

    change_table :entries do |t|
      t.rename :id, :uuid
      t.rename :sid, :id
    end

    execute 'ALTER TABLE entries ADD PRIMARY KEY (id)'
  end
end
