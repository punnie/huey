class StreamsController < ApplicationController
  before_action :set_controller_entities, only: :show

  def show
    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end

  private

  def set_controller_entities
    @streams = Stream.all.order(id: :asc)

    @stream = Stream.find(params[:id])

    @feeds = @stream.feeds

    @entries = @stream.entries.for_feed.page(filtered_params[:page]).per(default_per_page)
  end

  def default_per_page
    filtered_params[:per_page] || 100
  end

  def filtered_params
    params.slice(:page)
  end
end
