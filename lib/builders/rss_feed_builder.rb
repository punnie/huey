module Builders
  class RssFeedBuilder
    def build(uri, use_googlebot_agent: true)
      downloader = SafeDownloader.new(use_googlebot_agent: use_googlebot_agent)
      content = downloader.download(uri)
      feed = RSS::Parser.parse(content, validate: false)

      if feed.is_a? RSS::Atom::Feed
        AtomFeed.find_or_initialize_by(uri: uri)
      else
        RssFeed.find_or_initialize_by(uri: uri)
      end

      # local_feed.save!
    end
  end
end
