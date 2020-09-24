# frozen_string_literal: true

json.array! @feeds, partial: 'api/v2/feeds/feed', as: :feed
