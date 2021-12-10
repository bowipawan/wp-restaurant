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
end
