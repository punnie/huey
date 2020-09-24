# frozen_string_literal: true

json.array! @entries, partial: 'api/v2/entries/entry', as: :entry
