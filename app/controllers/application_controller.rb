# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    # TODO
    @current_user = User.first
  end

  attr_reader :current_user
end
