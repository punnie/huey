# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  has_neighbors :openai_embeddings

  after_commit :download_readable_content, on: :create

  scope :for_feed, -> { where(is_ready: true).order(published_date: :desc) }

  # Getting some PHP vibes here
  def real_uri
    return link if link =~ URI::DEFAULT_PARSER.make_regexp
    return uri if uri =~ URI::DEFAULT_PARSER.make_regexp

    raise StandardError, 'No valid URI found'
  end

  def mark_as_ready
    self.is_ready = true
  end

  def content
    contents["content"]
  end

  def sanitized_content
    sanitizer = Rails::Html::FullSanitizer.new
    sanitizer.sanitize(content).split(/\s/)[0...512].join(" ").strip rescue ""
  end

  private

  def download_readable_content
    if feed.download_content
      DownloadReadableContentJob.perform_later(entry: self)
    else
      mark_as_ready
      save!
    end
  end
end
