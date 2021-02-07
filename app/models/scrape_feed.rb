# typed: false
# frozen_string_literal: true

class ScrapeFeed < Feed
  def sync
    downloader = SafeDownloader.new
    content = downloader.download(uri)

    document = Nokogiri::HTML(content)

    # TODO: replace selector with dynamic setting
    news_elements = document.css(scrape_index_news_element_selector)

    news_elements.reverse.each do |el|
      headline = el.css(scrape_index_headline_selector).text
      summary = el.css(scrape_index_summary_selector).text
      illustration = el.css(scrape_index_illustration_selector).attribute(scrape_index_illustration_attribute_name)&.value
      date = el.css(scrape_index_date_selector).text
      author = el.css(scrape_index_author_selector).text
      link = scrape_index_link_base + el.css(scrape_index_link_selector).attribute(scrape_index_link_attribute_name)&.value

      entry = entries.find_or_initialize_by(uri: link)

      entry.authors = author.blank? ? nil : [author]
      entry.description = summary
      entry.link = link
      entry.title = headline
      entry.published_date ||= date || Time.now.utc
      entry.updated_date ||= date || Time.now.utc

      entry.save!
    end

    self.last_refreshed_at = Time.now

    save!
  end
end
