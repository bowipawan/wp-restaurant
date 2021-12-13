require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
    @restaurant = restaurants(:one)
    @user = nil
    @userone = users(:one)
    @usertwo = users(:two)
  end

  test "create first rate" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @usertwo.email
    fill_in "Password", with: 'two'
    click_on "Sign In"
    # create rate
    visit showrestaurant_url(@restaurant.restaurant_name)
    click_on "Rate"
    assert_text "Rate #{@restaurant.restaurant_name}"
    assert_text "Score (0-5)"
    fill_in "rate", with: "4"
    click_on "Rate"
    assert_text "#{@restaurant.restaurant_name}"
    assert_text "You have rated #{@restaurant.restaurant_name} with score 4"
  end

  test "edit rate" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @userone.email
    fill_in "Password", with: 'one'
    click_on "Sign In"
    # edit rate
    visit showrestaurant_url(@restaurant.restaurant_name)
    click_on "Rate"
    assert_text "Rate #{@restaurant.restaurant_name}"
    assert_text "Score (0-5)"
    fill_in "rate", with: "2"
    click_on "Rate"
    assert_text "#{@restaurant.restaurant_name}"
    assert_text "You have changed rate for #{@restaurant.restaurant_name} from score #{@rate.rate_score} to 2"
  end
end
