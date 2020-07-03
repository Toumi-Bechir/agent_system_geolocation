require "application_system_test_case"

class MasteragentsTest < ApplicationSystemTestCase
  setup do
    @masteragent = masteragents(:one)
  end

  test "visiting the index" do
    visit masteragents_url
    assert_selector "h1", text: "Masteragents"
  end

  test "creating a Masteragent" do
    visit masteragents_url
    click_on "New Masteragent"

    click_on "Create Masteragent"

    assert_text "Masteragent was successfully created"
    click_on "Back"
  end

  test "updating a Masteragent" do
    visit masteragents_url
    click_on "Edit", match: :first

    click_on "Update Masteragent"

    assert_text "Masteragent was successfully updated"
    click_on "Back"
  end

  test "destroying a Masteragent" do
    visit masteragents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Masteragent was successfully destroyed"
  end
end
