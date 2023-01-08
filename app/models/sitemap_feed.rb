# typed: false
# frozen_string_literal: true

class SitemapFeed < Feed
  def fetcher
    Fetchers::SitemapIndexFeedFetcher.new(feed: self)
  end
end
