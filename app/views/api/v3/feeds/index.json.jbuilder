# frozen_string_literal: true

json.feeds @feeds do |feed|
  json.partial! 'api/v3/feeds/feed', feed: feed
end

json.partial! 'api/v3/shared/pagination', collection: @feeds
