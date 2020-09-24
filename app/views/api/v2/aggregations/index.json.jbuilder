# frozen_string_literal: true

json.array! @aggregations, partial: 'api/v2/aggregations/aggregation', as: :aggregation
