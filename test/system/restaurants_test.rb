require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "visit restaurant page without login" do
    visit showrestaurant_url(@restaurant.restaurant_name)
    assert_text "Please login"
  end

  test "visit restaurant page" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restaurant.restaurant_name)
    assert_selector :link, "Appointment"
    assert_selector :link, "Rate"
    assert_selector :link, "Comment"
    assert_text @restaurant.restaurant_name
  end

  test "visit restaurant list page without login" do
    visit listrestaurant_url
    assert_text "Please login"
  end

  test "visit restaurant list page" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit listrestaurant_url
    assert_text "Restaurant"
    assert_text "Max Table"
    assert_text "Rate"
    assert_selector :table
    assert_selector :link, "Go"
  end
end
