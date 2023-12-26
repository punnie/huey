# typed: false
# frozen_string_literal: true

class EmbeddingSearcher # rubocop:disable Style/Documentation
  def search(scope:, text:, limit: 10, distance: 'cosine')
    fetcher = Openai::Embeddings.new
    embeddings = fetcher.fetch(text: text)

    scope.nearest_neighbors(:openai_embeddings, embeddings, distance: distance).limit(limit)
  end
end
