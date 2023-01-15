# typed: false
# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @feeds = Feed.all
    @chronological = params.key?(:chronological)

    respond_to do |format|
      format.html { render layout: 'layouts/application' }
    end
  end
end
