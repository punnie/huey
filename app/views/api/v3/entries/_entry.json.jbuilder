# frozen_string_literal: true

json.id entry.id.to_s

json.extract! entry,
              :uuid,
              :title,
              :published_date,
              :description,
              :link,
              :sanitized_content,
              :content
