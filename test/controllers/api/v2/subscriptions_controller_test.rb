# frozen_string_literal: true

require 'test_helper'

class Api::V2::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feed = feeds(:feed_one)
    @aggregation = aggregations(:aggregation_one)
    @subscription = subscriptions(:subscription_one)
  end

  test 'should get index' do
    get api_v2_subscriptions_url, as: :json
    assert_response :success
  end

  test 'should create subscription' do
    assert_difference('Subscription.count') do
      post api_v2_subscriptions_url, params: { subscription: { feed_id: @feed.id, aggregation_id: @aggregation.id } }, as: :json
    end

    assert_response 201
  end

  test 'should show subscription' do
    get api_v2_subscription_url(@subscription), as: :json
    assert_response :success
  end

  test 'should destroy subscription' do
    assert_difference('Subscription.count', -1) do
      delete api_v2_subscription_url(@subscription), as: :json
    end

    assert_response 204
  end
end
