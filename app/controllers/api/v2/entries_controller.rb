# frozen_string_literal: true

class Api::V2::EntriesController < ApplicationController
  before_action :set_entry, only: %i[show update destroy]

  # GET /api/v2/entries
  # GET /api/v2/entries.json
  def index
    @entries = Entry.all
  end

  # GET /api/v2/entries/1
  # GET /api/v2/entries/1.json
  def show; end

  # POST /api/v2/entries
  # POST /api/v2/entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render :show, status: :created, location: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v2/entries/1
  # PATCH/PUT /api/v2/entries/1.json
  def update
    if @entry.update(entry_params)
      render :show, status: :ok, location: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v2/entries/1
  # DELETE /api/v2/entries/1.json
  def destroy
    @entry.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def entry_params
    params.fetch(:entry, {})
  end
end
