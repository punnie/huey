require 'test_helper'

class Api::V2::FeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v2_feed = api_v2_feeds(:one)
  end

  test "should get index" do
    get api_v2_feeds_url, as: :json
    assert_response :success
  end

  test "should create api_v2_feed" do
    assert_difference('Api::V2::Feed.count') do
      post api_v2_feeds_url, params: { api_v2_feed: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_v2_feed" do
    get api_v2_feed_url(@api_v2_feed), as: :json
    assert_response :success
  end

  test "should update api_v2_feed" do
    patch api_v2_feed_url(@api_v2_feed), params: { api_v2_feed: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_v2_feed" do
    assert_difference('Api::V2::Feed.count', -1) do
      delete api_v2_feed_url(@api_v2_feed), as: :json
    end

    assert_response 204
  end
end
