# typed: false
# frozen_string_literal: true

module Fetchers
  class SitemapFeedFetcher < BaseFetcher
    def fetch(uri)
      downloader = SafeDownloader.new
      content = downloader.download(uri)

      document = Nokogiri::XML(content).remove_namespaces!

      document.xpath('//url/loc').map(&:text).each do |uri|
        entry = feed.entries.find_or_initialize_by(uri: uri) # TODO find last_modified_date
        entry.save!
      end

      feed.save!
    end
  end
end
