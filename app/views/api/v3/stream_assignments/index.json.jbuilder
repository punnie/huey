# frozen_string_literal: true

json.stream_assignments @stream_assignments do |stream_assignment|
  json.partial! 'api/v3/stream_assignments/stream_assignment', stream_assignment: stream_assignment
end

json.partial! 'api/v3/shared/pagination', collection: @stream_assignments
