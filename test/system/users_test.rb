require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visit profile page with login" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit home_url
    assert_text @user.display_name
    assert_selector :link, "Edit Profile"
    assert_text "Appointment"
  end

  test "visit profile page without login" do
    visit profile_url
    assert_text "Please login"
  end

  test "edit display name" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit home_url
    assert_text @user.display_name
    page.first(:link, "Edit Profile").click
    page.find('#display_name', :visible => false).set("oneja")
    click_on "Save"
    assert_text "oneja"
    assert_text "You have changed display name from #{@user.display_name} to oneja"
  end
end
