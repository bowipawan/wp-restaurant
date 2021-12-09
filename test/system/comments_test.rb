require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @comment = comments(:one)
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "comment restaurant" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restaurant.restaurant_name)
    click_on "Comment"
    assert_text "Comment #{@restaurant.restaurant_name}"
    fill_in "msg", with: 'Amazing'
    click_on "Comment"
    assert_text"#{@restaurant.restaurant_name}"
    assert_text"Amazing"
  end

  # test "visiting the index" do
  #   visit comments_url
  #   assert_selector "h1", text: "Comments"
  # end

  # test "creating a Comment" do
  #   visit comments_url
  #   click_on "New Comment"

  #   fill_in "Msg", with: @comment.msg
  #   fill_in "Restaurant", with: @comment.restaurant_id
  #   fill_in "User", with: @comment.user_id
  #   click_on "Create Comment"

  #   assert_text "Comment was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Comment" do
  #   visit comments_url
  #   click_on "Edit", match: :first

  #   fill_in "Msg", with: @comment.msg
  #   fill_in "Restaurant", with: @comment.restaurant_id
  #   fill_in "User", with: @comment.user_id
  #   click_on "Update Comment"

  #   assert_text "Comment was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Comment" do
  #   visit comments_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Comment was successfully destroyed"
  # end
end
