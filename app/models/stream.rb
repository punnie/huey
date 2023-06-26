class Stream < ApplicationRecord
  belongs_to :user, optional: true

  has_many :stream_assignments
  has_many :feeds, through: :stream_assignments

  has_many :entries, through: :feeds

  scope :sorted, -> { order(order: :asc) }
end
