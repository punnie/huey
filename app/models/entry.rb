# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  before_save :populate_feed_sid

  after_commit :download_readable_content, on: :create

  scope :for_feed, -> { where(is_ready: true).order(published_date: :desc) }

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

  def populate_feed_sid
    self.feed_sid = feed.sid unless feed.nil?
  end

  def download_readable_content
    DownloadReadableContentJob.perform_later(entry: self)
  end
end
