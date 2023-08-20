# frozen_string_literal: true

json.id stream.id.to_s

json.extract! stream,
              :name,
              :permalink,
              :order,
              :created_at,
              :updated_at

if params[:action] != 'index'
  json.feeds stream.stream_assignments, partial: 'api/v3/stream_assignments/stream_assignment', as: :stream_assignment
end
