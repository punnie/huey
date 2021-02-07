# typed: false
# frozen_string_literal: true

class SyncFeedJob < ApplicationJob
  def perform(feed:)
    feed.sync
  end
end
