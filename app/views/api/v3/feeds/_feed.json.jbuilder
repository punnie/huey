# frozen_string_literal: true

json.id feed.id.to_s

json.extract! feed,
              :authors,
              :categories,
              :contributors,
              :copyright,
              :description,
              :encoding,
              :feed_type,
              :image,
              :language,
              :link,
              :entry_links,
              :published_date,
              :title,
              :uri,
              :feed_uri,
              :last_refreshed_at,

              :type,

              :scrape_index_news_element_selector,
              :scrape_index_news_element_selector,
              :scrape_index_headline_selector,
              :scrape_index_summary_selector,
              :scrape_index_illustration_selector,
              :scrape_index_illustration_attribute_name,
              :scrape_index_link_selector,
              :scrape_index_link_attribute_name,
              :scrape_index_link_base,
              :scrape_index_date_selector,
              :scrape_index_date_format,
              :scrape_index_author_selector,

              :use_googlebot_agent,
              :download_content
