# frozen_string_literal: true

class Aggregation < ApplicationRecord
  belongs_to :user
  has_many :subscriptions

  before_validation :set_default_values

  def set_default_values
    self.permalink ||= MnemonicEncoder.generate
  end
end
