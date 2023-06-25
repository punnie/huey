# typed: false
# frozen_string_literal: true

module Fetchers
  class SitemapFeedFetcher < BaseFetcher
    def parse(content)
      document = Nokogiri::XML(content).remove_namespaces!

      document.xpath('//url').map do |el|
        {
          loc: el.xpath('loc').text,
          lastmod: el.xpath('lastmod').text
        }
      end.each do |u|
        entry = feed.entries.find_or_initialize_by(uri: u[:loc])
        date = u[:lastmod]

        entry.published_date ||= date || Time.now.utc
        entry.updated_date ||= Time.now.utc
        entry.save!
      end

      feed.save!
    end
  end
end
