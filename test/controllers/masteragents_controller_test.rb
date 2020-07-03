require 'test_helper'

class MasteragentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @masteragent = masteragents(:one)
  end

  test "should get index" do
    get masteragents_url
    assert_response :success
  end

  test "should get new" do
    get new_masteragent_url
    assert_response :success
  end

  test "should create masteragent" do
    assert_difference('Masteragent.count') do
      post masteragents_url, params: { masteragent: {  } }
    end

    assert_redirected_to masteragent_url(Masteragent.last)
  end

  test "should show masteragent" do
    get masteragent_url(@masteragent)
    assert_response :success
  end

  test "should get edit" do
    get edit_masteragent_url(@masteragent)
    assert_response :success
  end

  test "should update masteragent" do
    patch masteragent_url(@masteragent), params: { masteragent: {  } }
    assert_redirected_to masteragent_url(@masteragent)
  end

  test "should destroy masteragent" do
    assert_difference('Masteragent.count', -1) do
      delete masteragent_url(@masteragent)
    end

    assert_redirected_to masteragents_url
  end
end
