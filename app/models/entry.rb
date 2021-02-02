# typed: false
# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed
end
