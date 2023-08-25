# typed: false
# frozen_string_literal: true

class Api::V3::EntriesController < Api::V3::ApiController
  # GET /api/v3/entries
  def index
    @entries = search.page(search_params[:page]).per(default_per_page)
    render :index
  end

  private

  def search
    if search_params[:stream_id]
      scope = stream.entries
    else
      scope = Entry.all
    end

    scope = scope.where(is_ready: true)
    scope = scope.where(published_date: (DateTime.parse(search_params[:start_date])..)) if search_params[:start_date]
    scope = scope.where(published_date: (..DateTime.parse(search_params[:end_date]))) if search_params[:end_date]

    scope = embedding_searcher.search(scope: scope, text: search_params[:text]) if search_params[:text]

    scope
  end

  def search_params
    params.permit(:start_date, :end_date, :text, :stream_id, :page, :per_page, :format)
  end

  def default_per_page
    search_params[:per_page] || 10
  end

  def embedding_searcher
    @embedding_searcher ||= EmbeddingSearcher.new
  end

  def stream
    @stream = Stream.find(params[:stream_id])
  end
end
