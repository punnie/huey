class CreateStreamAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :stream_assignments, id: :bigint, default: -> { 'generate_snowflake_id()' } do |t|
      t.references :feed, null: false, foreign_key: true
      t.references :stream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
