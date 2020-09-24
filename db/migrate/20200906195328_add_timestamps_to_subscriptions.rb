# frozen_string_literal: true

class AddTimestampsToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :created_at, :datetime, precision: 6, null: false, default: -> { 'now()' }
    add_column :subscriptions, :updated_at, :datetime, precision: 6, null: false, default: -> { 'now()' }
  end
end
