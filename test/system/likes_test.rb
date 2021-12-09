require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  setup do
    @like = likes(:one)
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "like and unlike comment at restaurant page" do
    # login  
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restaurant.restaurant_name)
    # unlike
    page.first(:button, "Unlike").click
    assert_text "You have unlike"
    assert_selector :button, "Like"
    assert_selector :button, "Dislike"
    # like
    page.first(:button, "Like").click
    assert_text "You have like"
    assert_selector :button, "Unlike"
    assert_selector :button, "Dislike"
    # dislike
    page.first(:button, "Dislike").click
    assert_text "You have dislike"
    assert_selector :button, "Like"
    assert_selector :button, "Undislike"
    # undislike
    page.first(:button, "Undislike").click
    assert_text "You have undislike"
    assert_selector :button, "Like"
    assert_selector :button, "Dislike"
  end

  # test "visiting the index" do
  #   visit likes_url
  #   assert_selector "h1", text: "Likes"
  # end

  # test "creating a Like" do
  #   visit likes_url
  #   click_on "New Like"

  #   fill_in "Comment", with: @like.comment_id
  #   check "Like type" if @like.like_type
  #   fill_in "User", with: @like.user_id
  #   click_on "Create Like"

  #   assert_text "Like was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Like" do
  #   visit likes_url
  #   click_on "Edit", match: :first

  #   fill_in "Comment", with: @like.comment_id
  #   check "Like type" if @like.like_type
  #   fill_in "User", with: @like.user_id
  #   click_on "Update Like"

  #   assert_text "Like was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Like" do
  #   visit likes_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Like was successfully destroyed"
  # end
end
