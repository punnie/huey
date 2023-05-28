# typed: false
# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :set_feeds, only: [:index]

  def index
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end

  def chronological
    redirect_to stream_path(default_stream)
  end

  private

  def set_feeds
    @feeds = default_stream.feeds
  end

  def default_per_page
    filtered_params[:per_page] || 100
  end

  def filtered_params
    params.slice(:page, :per_page)
  end

  def default_stream
    Stream.first
  end
end
