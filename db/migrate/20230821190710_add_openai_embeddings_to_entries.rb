class AddOpenaiEmbeddingsToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :openai_embeddings, :vector, limit: 1536
  end
end
