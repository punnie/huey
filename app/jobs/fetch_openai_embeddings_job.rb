# typed: false
# frozen_string_literal: true

class FetchOpenaiEmbeddingsJob < ApplicationJob
  def perform(entry:)
    embeddings = fetcher.fetch(text: entry.sanitized_content)

    entry.openai_embeddings = embeddings
    entry.save
  end

  def fetcher
    @fetcher ||= Openai::Embeddings.new
  end
end
