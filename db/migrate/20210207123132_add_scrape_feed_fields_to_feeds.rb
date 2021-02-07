# typed: false
# frozen_string_literal: true

class AddScrapeFeedFieldsToFeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :scrape_index_news_element_selector, :string
    add_column :feeds, :scrape_index_headline_selector, :string
    add_column :feeds, :scrape_index_summary_selector, :string
    add_column :feeds, :scrape_index_illustration_selector, :string
    add_column :feeds, :scrape_index_illustration_attribute_name, :string
    add_column :feeds, :scrape_index_link_selector, :string
    add_column :feeds, :scrape_index_link_attribute_name, :string
    add_column :feeds, :scrape_index_link_base, :string
    add_column :feeds, :scrape_index_date_selector, :string
    add_column :feeds, :scrape_index_date_format, :string
    add_column :feeds, :scrape_index_author_selector, :string
  end
end
