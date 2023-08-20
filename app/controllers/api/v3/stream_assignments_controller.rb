# typed: false
# frozen_string_literal: true

class Api::V3::StreamAssignmentsController < Api::V3::ApiController
  before_action :set_stream_assignment, only: [:show, :update, :destroy]

  # POST /api/v3/streams
  def create
    @stream_assignment = StreamAssignment.find_or_initialize_by(stream_assignment_params)

    created = @stream_assignment.new_record?

    if @stream_assignment.save
      render :show, status: created ? :created : :ok
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
    params.require(:stream_assignment).permit(:stream_id, :feed_id)
  end

  def default_per_page
    pagination_params[:per_page] || 100
  end

  def pagination_params
    params.slice(:page)
  end
end
