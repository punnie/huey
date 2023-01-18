# typed: false
# frozen_string_literal: true

class AddUseGooglebotAgentToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :use_googlebot_agent, :boolean, null: false, default: true
  end
end
