class ChangeFeedsPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    change_table :entries do |t|
      t.remove :feed_id
      t.rename :feed_sid, :feed_id
    end

    change_table :feeds do |t|
      t.remove :id
      t.rename :sid, :id
    end

    execute 'ALTER TABLE feeds ADD PRIMARY KEY (id)'

    add_foreign_key :entries, :feeds, column: :feed_id, on_delete: :nullify
  end
end
