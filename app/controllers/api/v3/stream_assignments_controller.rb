# typed: false
# frozen_string_literal: true

class Api::V3::StreamAssignmentsController < Api::V3::ApiController
  before_action :set_stream_assignment, only: [:show, :update, :destroy]

  # GET /api/v3/streams
  def index
    @stream_assignments = StreamAssignment.all.page(pagination_params[:page]).per(default_per_page)
    render
  end

  # GET /api/v3/streams/:id
  def show
    render
  end

  # POST /api/v3/streams
  def create
    @stream_assignment = StreamAssignment.new(stream_assignment_params)
    if @stream_assignment.save
      render status: :created
    else
      render json: @stream_assignment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v3/streams/:id
  def update
    if @stream_assignment.update(stream_assignment_params)
      render
    else
      render json: @stream_assignment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v3/streams/:id
  def destroy
    @stream_assignment.destroy
    head :no_content
  end

  private

  def set_stream_assignment
    @stream_assignment = StreamAssignment.find(params[:id])
  end

  def stream_assignment_params
    params.require(:stream_assignment).permit(:title, :content)
  end

  def default_per_page
    pagination_params[:per_page] || 100
  end

  def pagination_params
    params.slice(:page)
  end
end
