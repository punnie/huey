# typed: false
# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_feed, only: %i[show]

  # GET /feeds/1.json
  # GET /feeds/1.rss
  def show
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
      format.json { render layout: false }
      format.rss { render layout: false }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def entry_limit
    return 100 if request.format.html?

    10
  end
end
