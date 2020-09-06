class Api::V2::FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :update, :destroy]

  # GET /api/v2/feeds
  # GET /api/v2/feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /api/v2/feeds/1
  # GET /api/v2/feeds/1.json
  def show
  end

  # POST /api/v2/feeds
  # POST /api/v2/feeds.json
  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      render :show, status: :created, location: @feed
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v2/feeds/1
  # PATCH/PUT /api/v2/feeds/1.json
  def update
    if @feed.update(feed_params)
      render :show, status: :ok, location: @feed
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v2/feeds/1
  # DELETE /api/v2/feeds/1.json
  def destroy
    @feed.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.fetch(:feed, {})
    end
end
