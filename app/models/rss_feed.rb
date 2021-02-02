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
      entry = entries.find_or_initialize_by(uri: item.guid.content)

      entry.authors = item.author.blank? ? nil : [item.author]
      entry.description = item.description
      entry.link = item.link
      entry.title = item.title
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
