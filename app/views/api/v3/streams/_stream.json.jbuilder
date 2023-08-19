# frozen_string_literal: true

json.id stream.id.to_s

json.extract! stream,
              :name,
              :permalink,
              :order,
              :created_at,
              :updated_at
