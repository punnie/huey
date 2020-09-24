# frozen_string_literal: true

require 'test_helper'

class Api::V2::AggregationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    @aggregation = aggregations(:aggregation_one)
  end

  test 'should get index' do
    get api_v2_aggregations_url, as: :json
    assert_response :success
  end

  test 'should create aggregation' do
    assert_difference('Aggregation.count') do
      post api_v2_aggregations_url, params: { aggregation: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show aggregation' do
    get api_v2_aggregation_url(@aggregation), as: :json
    assert_response :success
  end

  test 'should update aggregation' do
    patch api_v2_aggregation_url(@aggregation), params: { aggregation: {} }, as: :json
    assert_response 200
  end

  test 'should destroy aggregation' do
    assert_difference('Aggregation.count', -1) do
      delete api_v2_aggregation_url(@aggregation), as: :json
    end

    assert_response 204
  end
end
