# frozen_string_literal: true

json.version 'https://jsonfeed.org/version/1.1'
json.title @feed.title
json.description @feed.description

json.home_page_url @feed.link
json.feed_url api_v2_feed_url(@feed, format: :json)

json.items @entries do |entry|
  json.id entry.uri
  json.title entry.title
  json.summary entry.description
  json.date_published entry.published_date
  json.content_text entry.contents.fetch('content')
  json.url entry.uri
end
