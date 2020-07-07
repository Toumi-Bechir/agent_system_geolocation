require 'test_helper'

class SubagentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subagent = subagents(:one)
  end

  test "should get index" do
    get subagents_url
    assert_response :success
  end

  test "should get new" do
    get new_subagent_url
    assert_response :success
  end

  test "should create subagent" do
    assert_difference('Subagent.count') do
      post subagents_url, params: { subagent: {  } }
    end

    assert_redirected_to subagent_url(Subagent.last)
  end

  test "should show subagent" do
    get subagent_url(@subagent)
    assert_response :success
  end

  test "should get edit" do
    get edit_subagent_url(@subagent)
    assert_response :success
  end

  test "should update subagent" do
    patch subagent_url(@subagent), params: { subagent: {  } }
    assert_redirected_to subagent_url(@subagent)
  end

  test "should destroy subagent" do
    assert_difference('Subagent.count', -1) do
      delete subagent_url(@subagent)
    end

    assert_redirected_to subagents_url
  end
end
