# frozen_string_literal: true

json.streams @streams do |stream|
  json.partial! 'api/v3/streams/stream', stream: stream
end

json.partial! 'api/v3/shared/pagination', collection: @streams
