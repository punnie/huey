# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  after_commit :download_readable_content, on: :create

  scope :for_feed, -> { where(is_ready: true).order(published_date: :desc) }

  # Getting some PHP vibes here
  def real_uri
    return uri if uri =~ URI::DEFAULT_PARSER.make_regexp
    return link if link =~ URI::DEFAULT_PARSER.make_regexp

    raise StandardError, 'No valid URI found'
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

  def mark_as_ready
    self.is_ready = true
  end
end
