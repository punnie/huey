# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :aggregation
  belongs_to :feed
end
