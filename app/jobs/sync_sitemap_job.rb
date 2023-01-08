# typed: false
# frozen_string_literal: true

class SyncSitemapJob < ApplicationJob
  def perform(feed:, sitemap_uri:)
    Fetchers::SitemapFeedFetcher.new(feed: feed).fetch(sitemap_uri)
  end
end
