# typed: false
# frozen_string_literal: true

module Fetchers
  class AtomFeedFetcher < BaseFetcher
    attr_reader :scrubber, :sanitizer

    def parse(content)
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

        entry.description = sanitize_html(item.summary.content) if item.summary.present?
        entry.link = item.link.href if item.link.present?
        entry.title = item.title.content if item.title.present?

        entry.published_date = item.published&.content || item.updated&.content
        entry.updated_date = item.updated&.content || item.published&.content

        contents = item.content.content if item.content.present?

        if contents.present?
          entry.contents = {
            type: 'text/html',
            content: contents
          }

          entry.description = generate_description_from_content(contents) if entry.description.empty?
        end

        entry.save!
      end

      feed.save!
    end

    private

    def generate_description_from_content(content)
      fragment = Loofah.fragment(content)
      fragment.scrub!(scrubber)

      sanitize_html(fragment.to_s)
    end

    def sanitizer
      @sanitizer ||= Rails::Html::FullSanitizer.new
    end

    def scrubber
      @scrubber ||= Scrubbers::Description.new
    end

    def sanitize_html(content)
      sanitizer.sanitize(content).strip.gsub("\n", ' ').gsub(/\.(\[a-zA-Z\])/, '. \1')
    end
  end
end
