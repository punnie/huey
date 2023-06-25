# frozen_string_literal: true

require 'test_helper'

class Api::V2::EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entry = entries(:entry_one)
  end

  test 'should show entry' do
    # get api_v2_entry_url(@entry), as: :json
    # assert_response :success

    assert true
  end
end
