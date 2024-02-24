# typed: false
# frozen_string_literal: true

class StreamsController < ApplicationController
  before_action :set_controller_entities, only: :show

  def show
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
      format.js { render layout: false }
    end
  end

  private

  def set_controller_entities
    @streams = Stream.all.sorted
    @stream = Stream.find(filtered_params[:id])
    @feeds = @stream.feeds
    @entries = @stream.entries.for_feed.includes(:feed).page(filtered_params[:page]).per(default_per_page)
    @entry_layout = entry_layout
  end

  def default_per_page
    filtered_params[:per_page] || 100
  end

  def entry_layout
    case filtered_params[:l]
    when 'full'
      'entry'
    when 'cozy'
      'entry_cozy'
    when 'compact'
      'entry_compact'
    else
      'entry_cozy'
    end
  end

  def filtered_params
    params.permit(:id, :page, :per_page, :js, :l)
  end
end
