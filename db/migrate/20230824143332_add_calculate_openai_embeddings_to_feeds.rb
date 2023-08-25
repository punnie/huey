class AddCalculateOpenaiEmbeddingsToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :calculate_openai_embeddings, :boolean, default: false
  end
end
