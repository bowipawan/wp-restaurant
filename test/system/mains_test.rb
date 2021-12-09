require "application_system_test_case"

class MainsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting home page without login" do
    visit home_url
    assert_text "Please login."
  end

  test "login with correct password" do
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"
    assert_text "Successfully login."
  end

  test "login with wrong password" do
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'two'
    click_on "Sign In"
    assert_text "Wrong username or password."
  end

  test "register" do
    visit home_url
    click_on "Register"
    assert_text "Sign Up"
    fill_in "Email", with: "three@email"
    fill_in "Display name", with: "three"
    fill_in "Password", with: "three", match: :first
    fill_in "Password confirmation", with: "three"
    click_on "Sign Up"
    assert_text "Successfully registered"

    click_on "Register"
    fill_in "Email", with: "three@email"
    fill_in "Display name", with: "three"
    fill_in "Password", with: "three", match: :first
    fill_in "Password confirmation", with: "four"
    click_on "Sign Up"
    assert_text "Password confirmation doesn't match Password"
    assert_text "Email has already been taken"
  end
end