# frozen_string_literal: true

require 'test_helper'

class Api::V2::FeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feed = feeds(:feed_one)
  end

  test 'should get index' do
    get api_v2_feeds_url, as: :json
    assert_response :success
  end

  test 'should create feed' do
    assert_difference('Feed.count') do
      post api_v2_feeds_url, params: { feed: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show feed' do
    get api_v2_feed_url(@feed), as: :json
    assert_response :success
  end

  test 'should update feed' do
    patch api_v2_feed_url(@feed), params: { feed: {} }, as: :json
    assert_response 200
  end

  test 'should destroy feed' do
    assert_difference('Feed.count', -1) do
      delete api_v2_feed_url(@feed), as: :json
    end

    assert_response 204
  end
end
