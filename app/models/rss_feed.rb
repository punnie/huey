# typed: false
# frozen_string_literal: true

class RssFeed < Feed
  def fetcher
    Fetchers::RssFeedFetcher.new(feed: self)
  end
end
