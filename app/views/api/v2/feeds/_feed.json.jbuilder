json.extract! feed, :id, :created_at, :updated_at
json.url api_v2_feed_url(feed, format: :json)
