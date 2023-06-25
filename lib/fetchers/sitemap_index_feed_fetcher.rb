# typed: false
# frozen_string_literal: true

module Fetchers
  class SitemapIndexFeedFetcher < BaseFetcher
    attr_reader :limit_sitemaps

    def initialize(feed:, limit_sitemaps: 2)
      @limit_sitemaps = limit_sitemaps

      super(feed: feed)
    end

    def parse(content)
      document = Nokogiri::XML(content).remove_namespaces!

      document.xpath('//sitemap/loc').first(limit_sitemaps).map(&:text).each do |u|
        SyncSitemapJob.perform_later(feed: feed, sitemap_uri: u)
      end

      feed.last_refreshed_at = Time.now
      feed.save!
    end
  end
end
