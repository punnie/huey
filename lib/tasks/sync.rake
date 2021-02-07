# typed: false
# frozen_string_literal: true

namespace :sync do
  task :feeds => :environment do
    Feed.all.each do |f|
      SyncFeedJob.perform_later(feed: f)
    end
  end
end
