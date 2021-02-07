# typed: false
# frozen_string_literal: true

class Api::V2::FeedsController < ApplicationController
  before_action :set_feed, only: %i[show]

  # GET /api/v2/feeds/1
  # GET /api/v2/feeds/1.json
  # GET /api/v2/feeds/1.rss
  def show
    @entries = @feed.entries.order(published_date: :desc).limit(10)

    respond_to do |format|
      format.html
      format.json { render layout: false }
      format.rss { render layout: false }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end
end
