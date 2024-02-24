# typed: false
# frozen_string_literal: true

class Api::V3::ApiController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  protected

  def authenticate_user!
    token = extract_token_from_header

    if token.nil? || !valid_token?(token)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def extract_token_from_header
    header = request.headers['Authorization']
    header&.gsub(/^Bearer /, '')
  end

  def valid_token?(token)
    User.where(token: token).first.present?
  end
end
