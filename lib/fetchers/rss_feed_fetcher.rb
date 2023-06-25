# typed: false
# frozen_string_literal: true

module Fetchers
  class RssFeedFetcher < BaseFetcher
    def parse(content)
      rss_feed = RSS::Parser.parse(content, validate: false)

      feed.description ||= rss_feed.channel.description
      feed.title ||= rss_feed.channel.title
      feed.link ||= rss_feed.channel.link

      feed.copyright = rss_feed.channel.try(:copyright)
      feed.published_date = rss_feed.channel.try(:pubDate)

      feed.last_refreshed_at = Time.now

      rss_feed.items.each do |item|
        guid = item.try(:guid).try(:content) || item.link
        entry = feed.entries.find_or_initialize_by(uri: guid)

        entry.authors = get_item_author(item)

        entry.description = Nokogiri::XML("<el>#{item.description}</el>").text.strip

        entry.title = Nokogiri::XML("<el>#{item.title}</el>").text.strip
        entry.link = item.link

        entry.published_date = item.try(:pubDate) || item.try(:dc_date)
        entry.updated_date = item.try(:pubDate) || item.try(:dc_date)

        contents = item.content_encoded

        if contents.present?
          entry.contents = {
            type: 'text/html',
            content: contents
          }
        end

        entry.save!
      end

      feed.save!
    end

    private

    def get_item_author(item)
      return [item.author] unless item.try(:author).blank?

      return [item.dc_creator] unless item.try(:dc_creator).blank?

      []
    end
  end
end
