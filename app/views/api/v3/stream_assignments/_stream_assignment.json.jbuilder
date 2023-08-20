# frozen_string_literal: true

json.id stream_assignment.id.to_s

json.feed_id stream_assignment.feed_id.to_s
json.extract! stream_assignment.feed,
              :type,
              :uri,
              :title

json.extract! stream_assignment,
              :created_at,
              :updated_at
