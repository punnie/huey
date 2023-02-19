# typed: false
# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_feed, only: %i[show]

  # GET /feeds/1.json
  # GET /feeds/1.rss
  def show
    respond_to do |format|
      format.html do
        @entries = @feed.entries.for_feed.page(params[:page]).per(default_per_page_html)
        render layout: 'layouts/application'
      end

      format.json do
        @entries = @feed.entries.for_feed.page(params[:page]).per(default_per_page_feeds)
        render layout: false
      end

      format.rss do
        @entries = @feed.entries.for_feed.page(params[:page]).per(default_per_page_feeds)
        render layout: false
      end
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def default_per_page_html
    params[:per_page] || 100
  end

  def default_per_page_feeds
    params[:per_page] || 25
  end
end
