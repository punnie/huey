# typed: false
# frozen_string_literal: true

class DownloadReadableContentJob < ApplicationJob
  attr_reader :mercury_api_url

  def perform(entry:)
    downloader = ReadableContentDownloader.new(mercury_api_url: mercury_api_url)
    content = downloader.download(entry.real_uri, use_googlebot_agent: entry.feed.use_googlebot_agent)

    entry.readable_content = content

    entry.title = content.title if entry.title.blank?

    entry.authors = ((entry.authors || []) + [content.author]).uniq.compact
    entry.published_date = content.date_published if entry.published_date.blank?
    entry.description = content.excerpt if entry.description.blank?

    entry.link = content.url
    entry.updated_date = Time.now.utc

    entry.contents = {
      type: 'text/html',
      content: content.content
    }

    entry.is_ready = true
    entry.save!
  end

  private

  def mercury_api_url
    ENV['MERCURY_API_URL'] || 'https://mercury-api.ethereal.io/content'
  end
end
