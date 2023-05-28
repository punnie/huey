# typed: false
# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :set_entries, only: [:chronological]
  before_action :set_feeds, only: [:index]
  before_action :set_streams

  def index
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end

  def chronological
    redirect_to stream_path(Stream.first)
  end

  private

  def set_feeds
    @feeds = Feed.all
  end

  def set_streams
    @streams = Stream.all
  end

  def set_entries
    @entries = Entry.all.for_feed.page(filtered_params[:page]).per(default_per_page)
  end

  def default_per_page
    filtered_params[:per_page] || 100
  end

  def filtered_params
    params.slice(:page, :per_page)
  end
end
