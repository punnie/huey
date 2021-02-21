# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  after_commit :download_readable_content, on: %i[create update]

  # Getting some PHP vibes here
  def real_uri
    return uri if uri =~ URI::DEFAULT_PARSER.make_regexp
    return link if link =~ URI::DEFAULT_PARSER.make_regexp

    raise StandardError, 'No valid URI found'
  end

  private

  def download_readable_content
    DownloadReadableContentJob.perform_later(entry: self)
  end
end
