class Aggregation < ApplicationRecord
  belongs_to :user
  has_many :subscriptions
end
