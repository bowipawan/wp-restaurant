require "application_system_test_case"

class AppointmentsTest < ApplicationSystemTestCase
  setup do
    @appointment = appointments(:one)
    @restaurantone = restaurants(:one)
    @restauranttwo = restaurants(:two)
    @user = users(:one)
    @userone = nil
    @usertwo = nil
  end

  test "show appointment in home page" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    assert_text @restaurantone.restaurant_name
  end

  test "delete appointment in home page" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    page.accept_confirm do
      click_on "Delete"
    end
    assert_no_text @restaurantone.restaurant_name
    
  end

  test "create appointment" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restauranttwo.restaurant_name)
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"
    select "2", from: "Choose Table"
    select "14:00 - 16:00", from: "Choose Time"
    fill_in "People Amount", with: "3"
    click_on "Confirm"
    assert_text "You have booked #{@restauranttwo.restaurant_name}"
    assert_text "Restaurant : #{@restauranttwo.restaurant_name}"
    assert_text "People Amount : 3"
    assert_text "10:00 - 12:00"
    assert_text "Table Number : 1"
  end

  test "create existing appointment" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restauranttwo.restaurant_name)
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"
    select "2", from: "Choose Table"
    select "14:00 - 16:00", from: "Choose Time"
    fill_in "People Amount", with: "3"
    click_on "Confirm"
    assert_text "You have booked #{@restauranttwo.restaurant_name}"
    assert_text "Restaurant : #{@restauranttwo.restaurant_name}"
    assert_text "People Amount : 3"
    assert_text "10:00 - 12:00"
    assert_text "Table Number : 1"

    visit showrestaurant_url(@restauranttwo.restaurant_name)
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"
    select "2", from: "Choose Table"
    select "14:00 - 16:00", from: "Choose Time"
    fill_in "People Amount", with: "3"
    click_on "Confirm"
    assert_text "Your chosen table is full at that time. Please choose other table"
  end

  test "create appointment with exceed people amount" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restauranttwo.restaurant_name)
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"

    select "2", from: "Choose Table"
    select "14:00 - 16:00", from: "Choose Time"
    fill_in "People Amount", with: "99"
    click_on "Confirm"
    assert_text "Your people amount exceed table capacity. Please choose other table"
  end

  test "create appointment with no people amount" do
    # login  
    sleep(1)
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restauranttwo.restaurant_name)
    click_on "Appointment"
    assert_text "Choose Table"
    assert_text "Choose Time"
    assert_text "People Amount"
    select "2", from: "Choose Table"
    select "14:00 - 16:00", from: "Choose Time"
    click_on "Confirm"
    assert_text "Please fill people amount"
  end
end
