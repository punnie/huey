# typed: false
# frozen_string_literal: true

class Api::V3::StreamsController < Api::V3::ApiController
  before_action :set_stream, only: [:show, :update, :destroy]

  # GET /api/v3/streams
  def index
    @streams = Stream.all.includes(:feeds).page(pagination_params[:page]).per(default_per_page)
    render :index
  end

  # GET /api/v3/streams/:id
  def show
    render :show
  end

  # POST /api/v3/streams
  def create
    @stream = Stream.new(stream_params)
    if @stream.save
      render :show, status: :created
    else
      render json: @stream.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v3/streams/:id
  def update
    if @stream.update(stream_params)
      render :show
    else
      render json: @stream.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v3/streams/:id
  def destroy
    @stream.destroy
    head :no_content
  end

  private

  def set_stream
    @stream = Stream.find(params[:id])
  end

  def stream_params
    params.require(:stream).permit(:name, :permalink)
  end

  def default_per_page
    pagination_params[:per_page] || 100
  end

  def pagination_params
    params.slice(:page)
  end
end
