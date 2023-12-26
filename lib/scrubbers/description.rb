# typed: false
# frozen_string_literal: true

module Scrubbers
  class Description < Loofah::Scrubber
    attr_reader :tags

    def initialize # rubocop:disable Lint/MissingSuper
      @direction = :top_down
      @tags = %w[a div p span]
    end

    def scrub(node)
      if tags.include?(node.name)
        node.after(node.children)
        node.remove

        CONTINUE
      else
        node.remove

        STOP
      end
    end
  end
end
