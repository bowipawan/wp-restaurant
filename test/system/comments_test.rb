require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @comment = comments(:one)
    @restaurant = restaurants(:one)
    @user = nil
    @userone = users(:one)
    @usertwo = users(:two)
  end

  test "create first comment" do
    # login  
    visit login_url
    fill_in "Email", with: @usertwo.email
    fill_in "Password", with: 'two'
    click_on "Sign In"
    # create comment
    visit showrestaurant_url(@restaurant.restaurant_name)
    click_on "Comment"
    assert_text "Comment #{@restaurant.restaurant_name}"
    page.find('#msg', :visible => false).set("Amazing")
    click_on "Comment"
    assert_text"#{@restaurant.restaurant_name}"
    assert_text"Amazing"
  end

  test "edit comment" do
    # login  
    visit login_url
    fill_in "Email", with: @userone.email
    fill_in "Password", with: 'one'
    click_on "Sign In"
    # edit comment
    visit showrestaurant_url(@restaurant.restaurant_name)
    click_on "Comment"
    assert_text "Comment #{@restaurant.restaurant_name}"
    assert_text @comment.msg
    page.find('#msg', :visible => false).set("Wow")
    click_on "Comment"
    assert_text "#{@restaurant.restaurant_name}"
    assert_text "You have edited comment for #{@restaurant.restaurant_name}"
    assert_text "Wow"
  end

  test "delete comment" do
    # login
    visit login_url
    fill_in "Email", with: @userone.email
    fill_in "Password", with: 'one'
    click_on "Sign In"
    # edit comment
    visit showrestaurant_url(@restaurant.restaurant_name)
    assert_text @comment.msg
    assert_selector :link, "Delete"
    page.accept_confirm do
      click_on "Delete", match: :first
    end
    assert_no_text @comment.msg
    assert_text "You have deleted comment"
  end
end
