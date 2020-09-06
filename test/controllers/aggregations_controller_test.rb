require 'test_helper'

class AggregationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aggregation = aggregations(:one)
  end

  test "should get index" do
    get aggregations_url, as: :json
    assert_response :success
  end

  test "should create aggregation" do
    assert_difference('Aggregation.count') do
      post aggregations_url, params: { aggregation: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show aggregation" do
    get aggregation_url(@aggregation), as: :json
    assert_response :success
  end

  test "should update aggregation" do
    patch aggregation_url(@aggregation), params: { aggregation: {  } }, as: :json
    assert_response 200
  end

  test "should destroy aggregation" do
    assert_difference('Aggregation.count', -1) do
      delete aggregation_url(@aggregation), as: :json
    end

    assert_response 204
  end
end
