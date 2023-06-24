module Builders
  class RssFeedBuilder
    def build(uri)
      downloader = SafeDownloader.new
      content = downloader.download(uri)
      feed = RSS::Parser.parse(content, validate: false)

      local_feed = if feed.is_a? RSS::Atom::Feed
                     AtomFeed.find_or_initialize_by(uri: uri)
                   else
                     RssFeed.find_or_initialize_by(uri: uri)
                   end

      local_feed.save!
    end
  end
end
