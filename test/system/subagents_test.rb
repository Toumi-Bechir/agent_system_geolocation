require "application_system_test_case"

class SubagentsTest < ApplicationSystemTestCase
  setup do
    @subagent = subagents(:one)
  end

  test "visiting the index" do
    visit subagents_url
    assert_selector "h1", text: "Subagents"
  end

  test "creating a Subagent" do
    visit subagents_url
    click_on "New Subagent"

    click_on "Create Subagent"

    assert_text "Subagent was successfully created"
    click_on "Back"
  end

  test "updating a Subagent" do
    visit subagents_url
    click_on "Edit", match: :first

    click_on "Update Subagent"

    assert_text "Subagent was successfully updated"
    click_on "Back"
  end

  test "destroying a Subagent" do
    visit subagents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subagent was successfully destroyed"
  end
end
