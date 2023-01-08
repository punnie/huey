# typed: false
# frozen_string_literal: true

class ScrapeFeed < Feed
  def fetcher
    Fetchers::ScrapeFeedFetcher.new(feed: self)
  end
end
