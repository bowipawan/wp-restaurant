require "application_system_test_case"

class AppointmentsTest < ApplicationSystemTestCase
  setup do
    @appointment = appointments(:one)
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  # test "show appointment in home page" do
  #   # login  
  #   visit login_url
  #   fill_in "Email", with: @user.email
  #   fill_in "Password", with: 'one'
  #   click_on "Sign In"

  #   assert_text @restaurant.restaurant_name
  # end

  test "create appointment" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    assert_text @restaurant.restaurant_name
    click_on @restaurant.restaurant_name
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"

  end

end
