# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries
  has_many :subscriptions
end
