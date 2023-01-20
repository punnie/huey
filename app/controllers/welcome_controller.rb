# typed: false
# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :set_feeds, only: [:index]
  before_action :set_entries, only: [:chronological]

  def index
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end

  def chronological
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end

  private

  def set_feeds
    @feeds = Feed.all
  end

  def set_entries
    @entries = Entry.all.for_feed.page(params[:page]).per(default_per_page)
  end

  def default_per_page
    params[:per_page] || 100
  end
end
