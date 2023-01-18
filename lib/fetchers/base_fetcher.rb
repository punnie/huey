module Fetchers
  class BaseFetcher
    attr_reader :feed

    def initialize(feed:)
      @feed = feed
    end

    def fetch(uri); end
  end
end
