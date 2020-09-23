class Api::V2::AggregationsController < ApplicationController
  before_action :set_aggregation, only: %i[show update destroy]

  # GET /api/v2/aggregations
  # GET /api/v2/aggregations.json
  def index
    @aggregations = Aggregation.all
  end

  # GET /api/v2/aggregations/1
  # GET /api/v2/aggregations/1.json
  def show; end

  # POST /api/v2/aggregations
  # POST /api/v2/aggregations.json
  def create
    @aggregation = Aggregation.new(aggregation_params)

    if @aggregation.save
      render :show, status: :created, location: @aggregation
    else
      render json: @aggregation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v2/aggregations/1
  # PATCH/PUT /api/v2/aggregations/1.json
  def update
    if @aggregation.update(aggregation_params)
      render :show, status: :ok, location: @aggregation
    else
      render json: @aggregation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v2/aggregations/1
  # DELETE /api/v2/aggregations/1.json
  def destroy
    @aggregation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_aggregation
    @aggregation = Aggregation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def aggregation_params
    params.fetch(:aggregation, {})
  end
end
