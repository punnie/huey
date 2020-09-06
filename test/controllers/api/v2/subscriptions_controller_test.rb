require 'test_helper'

class Api::V2::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get api_v2_subscriptions_url, as: :json
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Api::V2::Subscription.count') do
      post api_v2_subscriptions_url, params: { subscription: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show subscription" do
    get api_v2_subscription_url(@subscription), as: :json
    assert_response :success
  end

  test "should update subscription" do
    patch api_v2_subscription_url(@subscription), params: { subscription: {  } }, as: :json
    assert_response 200
  end

  test "should destroy subscription" do
    assert_difference('Api::V2::Subscription.count', -1) do
      delete api_v2_subscription_url(@subscription), as: :json
    end

    assert_response 204
  end
end
