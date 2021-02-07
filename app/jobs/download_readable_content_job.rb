# typed: false
# frozen_string_literal: true

class DownloadReadableContentJob < ApplicationJob
  def perform(entry:)
    downloader = ReadableContentDownloader.new(mercury_api_url: ENV['MERCURY_API_URL'])
    content = downloader.download(entry.real_uri)

    entry.readable_content = content

    entry.authors = ((entry.authors || []) + [content.author]).uniq.compact
    entry.published_date = content.date_published if entry.published_date.blank?
    entry.description = content.excerpt if entry.description.blank?

    entry.link = content.url
    entry.updated_date = Time.now.utc

    entry.contents = {
      type: 'text/html',
      content: content.content,
    }

    entry.is_ready = true
    entry.save!
  end
end
