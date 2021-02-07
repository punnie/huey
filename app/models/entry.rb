# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  after_create :download_readable_content

  private

  def download_readable_content
    DownloadReadableContentJob.perform_later(entry: self)
  end
end
