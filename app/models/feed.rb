# typed: false
# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries

  def fetcher
    BaseFetcher.new(feed: self)
  end

  def sync
    fetcher.fetch(uri)
  end
end
