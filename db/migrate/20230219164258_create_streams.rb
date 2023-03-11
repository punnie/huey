class CreateStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :streams, id: :bigint, default: -> { 'generate_snowflake_id()' } do |t|
      t.string :name
      t.string :permalink
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
