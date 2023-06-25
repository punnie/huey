module Fetchers
  class BaseFetcher
    attr_reader :feed

    def initialize(feed:)
      @feed = feed
    end

    def fetch(uri)
      parse(grab(uri))
    end

    def grab(uri)
      downloader = SafeDownloader.new(use_googlebot_agent: feed.use_googlebot_agent)
      downloader.download(uri)
    end

    def parse(content); end
  end
end
