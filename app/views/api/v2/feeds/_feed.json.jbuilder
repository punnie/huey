json.extract! feed, :id, :last_refreshed_at
json.url api_v2_feed_url(feed, format: :json)
