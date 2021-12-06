require "application_system_test_case"

class RestausTest < ApplicationSystemTestCase
  setup do
    @restau = restaus(:one)
  end

  test "visiting the index" do
    visit restaus_url
    assert_selector "h1", text: "Restaus"
  end

  test "creating a Restau" do
    visit restaus_url
    click_on "New Restau"

    fill_in "Restau name", with: @restau.restau_name
    click_on "Create Restau"

    assert_text "Restau was successfully created"
    click_on "Back"
  end

  test "updating a Restau" do
    visit restaus_url
    click_on "Edit", match: :first

    fill_in "Restau name", with: @restau.restau_name
    click_on "Update Restau"

    assert_text "Restau was successfully updated"
    click_on "Back"
  end

  test "destroying a Restau" do
    visit restaus_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Restau was successfully destroyed"
  end
end
