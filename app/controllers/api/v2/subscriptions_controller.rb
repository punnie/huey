class Api::V2::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy]

  # GET /api/v2/subscriptions
  # GET /api/v2/subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /api/v2/subscriptions/1
  # GET /api/v2/subscriptions/1.json
  def show
  end

  # POST /api/v2/subscriptions
  # POST /api/v2/subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render :show, status: :created, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v2/subscriptions/1
  # PATCH/PUT /api/v2/subscriptions/1.json
  def update
    if @subscription.update(subscription_params)
      render :show, status: :ok, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v2/subscriptions/1
  # DELETE /api/v2/subscriptions/1.json
  def destroy
    @subscription.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.fetch(:subscription, {})
    end
end
