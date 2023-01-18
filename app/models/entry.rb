# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  after_commit :download_readable_content, on: :create

  scope :for_feed, ->(entry_limit = 10) { where(is_ready: true).order(published_date: :desc).limit(entry_limit) }

  # Getting some PHP vibes here
  def real_uri
    return uri if uri =~ URI::DEFAULT_PARSER.make_regexp
    return link if link =~ URI::DEFAULT_PARSER.make_regexp

    raise StandardError, 'No valid URI found'
  end

  def to_param
    sid.to_s
  end

  private

  def download_readable_content
    DownloadReadableContentJob.perform_later(entry: self)
  end
end
