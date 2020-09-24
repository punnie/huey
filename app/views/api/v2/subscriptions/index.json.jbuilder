# frozen_string_literal: true

json.array! @subscriptions, partial: 'api/v2/subscriptions/subscription', as: :subscription
