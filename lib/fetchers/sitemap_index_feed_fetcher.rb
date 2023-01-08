# typed: false
# frozen_string_literal: true

module Fetchers
  class SitemapIndexFeedFetcher < BaseFetcher
    def fetch(uri)
      downloader = SafeDownloader.new
      content = downloader.download(uri)

      document = Nokogiri::XML(content).remove_namespaces!

      document.xpath('//sitemap/loc').first(2).map(&:text).each do |uri| # TODO magic number
        SyncSitemapJob.perform_later(feed: feed, sitemap_uri: uri)
      end

      feed.last_refreshed_at = Time.now
      feed.save!
    end
  end
end
