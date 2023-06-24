# typed: false
# frozen_string_literal: true

class AtomFeed < Feed
  def fetcher
    Fetchers::AtomFeedFetcher.new(feed: self)
  end
end
