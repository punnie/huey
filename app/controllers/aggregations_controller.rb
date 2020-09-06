class AggregationsController < ApplicationController
  before_action :set_aggregation, only: [:show, :update, :destroy]

  # GET /aggregations
  # GET /aggregations.json
  def index
    @aggregations = Aggregation.all
  end

  # GET /aggregations/1
  # GET /aggregations/1.json
  def show
  end

  # POST /aggregations
  # POST /aggregations.json
  def create
    @aggregation = Aggregation.new(aggregation_params)

    if @aggregation.save
      render :show, status: :created, location: @aggregation
    else
      render json: @aggregation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /aggregations/1
  # PATCH/PUT /aggregations/1.json
  def update
    if @aggregation.update(aggregation_params)
      render :show, status: :ok, location: @aggregation
    else
      render json: @aggregation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /aggregations/1
  # DELETE /aggregations/1.json
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
