# typed: false
# frozen_string_literal: true

class Api::V3::FeedsController < Api::V3::ApiController
  before_action :set_feed, only: [:show, :update, :destroy]

  # GET /api/v3/feeds
  def index
    @feeds = Feed.all.page(pagination_params[:page]).per(default_per_page)
    render :index
  end

  # GET /api/v3/feeds/:id
  def show
    render :show
  end

  # POST /api/v3/feeds
  def create
    @feed = Builders::RssFeedBuilder.new.build(feed_params[:uri], use_googlebot_agent: feed_params[:use_googlebot_agent])

    created = @feed.new_record?

    if @feed.save
      render :show, status: created ? :created : :ok
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v3/feeds/:id
  def update
    if @feed.update(feed_params)
      render :show
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v3/feeds/:id
  def destroy
    @feed.destroy
    head :no_content
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:uri, :use_googlebot_agent)
  end

  def default_per_page
    pagination_params[:per_page] || 100
  end

  def pagination_params
    params.slice(:page)
  end
end
