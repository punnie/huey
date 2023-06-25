# typed: false
# frozen_string_literal: true

module Fetchers
  class AtomFeedFetcher < BaseFetcher
    def fetch(uri)
      downloader = SafeDownloader.new
      content = downloader.download(uri)

      atom_feed = RSS::Parser.parse(content, validate: false)

      feed.feed_type ||= atom_feed.feed_type

      feed.title ||= atom_feed.title&.content
      feed.link ||= atom_feed.link&.href

      feed.copyright ||= atom_feed.rights&.content
      feed.published_date ||= atom_feed.updated&.content

      feed.last_refreshed_at = Time.now

      atom_feed.items.each do |item|
        guid = item.id.content
        entry = feed.entries.find_or_initialize_by(uri: guid)

        entry.description = ''
        entry.link = item.link.href
        entry.title = item.title.content
        entry.published_date = item.published&.content || item.updated&.content
        entry.updated_date = item.updated&.content || item.published&.content

        contents = item.content.content

        if contents.present?
          entry.contents = {
            type: 'text/html',
            content: contents
          }

          entry.description = scrub_html(contents)
        end

        entry.save!
      end

      feed.save!
    end

    private

    def scrub_html(content)
      fragment = Loofah.fragment(content)
      scrubber = Scrubbers::Description.new
      sanitizer = Rails::Html::FullSanitizer.new


      fragment.scrub!(scrubber)

      sanitizer.sanitize(fragment.to_s.strip.gsub("\n", ' ').gsub(/\.(\S)/, '. \1'))
    end
  end
end
