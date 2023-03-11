# typed: false
# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries

  has_many :stream_assignments
  has_many :streams, through: :stream_assignments

  def fetcher
    BaseFetcher.new(feed: self)
  end

  def sync
    fetcher.fetch(uri)
  end
end
