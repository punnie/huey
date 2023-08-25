# frozen_string_literal: true

json.entries @entries do |entry|
  json.partial! 'api/v3/entries/entry', entry: entry
end

json.partial! 'api/v3/shared/pagination', collection: @entries
