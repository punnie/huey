# frozen_string_literal: true

json.extract! entry, :id, :published_date
json.url api_v2_entry_url(entry, format: :json)
