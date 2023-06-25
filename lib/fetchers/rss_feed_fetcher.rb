# typed: false
# frozen_string_literal: true

module Fetchers
  class RssFeedFetcher < BaseFetcher
    def parse(content)
      rss_feed = RSS::Parser.parse(content, validate: false)

      feed.description ||= rss_feed.channel.description
      feed.title ||= rss_feed.channel.title
      feed.link ||= rss_feed.channel.link

      feed.copyright = rss_feed.channel.copyright
      feed.published_date = rss_feed.channel.pubDate

      feed.last_refreshed_at = Time.now

      rss_feed.items.each do |item|
        guid = item.guid&.content || item.link
        entry = feed.entries.find_or_initialize_by(uri: guid)

        entry.authors = item.author.blank? ? nil : [item.author]
        entry.description = Nokogiri::XML("<el>#{item.description}</el>").text.strip
        entry.link = item.link
        entry.title = Nokogiri::XML("<el>#{item.title}</el>").text.strip
        entry.published_date = item.pubDate
        entry.updated_date = item.pubDate

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
  end
end
