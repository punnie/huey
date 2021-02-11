# typed: false
# frozen_string_literal: true

class RssFeed < Feed
  def sync
    downloader = SafeDownloader.new
    content = downloader.download(uri)

    feed = RSS::Parser.parse(content, validate: false)

    self.copyright = feed.channel.copyright
    self.description = feed.channel.description
    self.link = feed.channel.link
    self.published_date = feed.channel.pubDate
    self.title = feed.channel.title

    self.last_refreshed_at = Time.now

    feed.items.each do |item|
      guid = item.guid&.content || item.link
      entry = entries.find_or_initialize_by(uri: guid)

      entry.authors = item.author.blank? ? nil : [item.author]
      entry.description = Nokogiri::XML('<el>' + item.description + '</el>').text.strip
      entry.link = item.link
      entry.title = Nokogiri::XML('<el>' + item.title + '</el>').text.strip
      entry.published_date = item.pubDate
      entry.updated_date = item.pubDate

      contents = item.content_encoded

      if contents.present?
        entry.contents = {
          type: 'text/html',
          content: contents,
        }
      end

      entry.save!
    end

    save!
  end
end
