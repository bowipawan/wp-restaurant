require "application_system_test_case"

class FavoritesTest < ApplicationSystemTestCase
  setup do
    @favorite = favorites(:one)
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "favorite and unfavorite at restaurant page" do
    # login
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit showrestaurant_url(@restaurant.restaurant_name)
    page.first(:button, "Unfavorite").click
    assert_text "You have unfavorite"
    page.first(:button, "Favorite").click
    assert_text "You have favorite"
  end

  test "unfavorite at favorite page" do
    # login
    visit login_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'one'
    click_on "Sign In"

    visit listfavorite_url
    page.accept_confirm do
      click_on "Unfavorite"
    end
    assert_text "Favorite Restaurants"
  end
end
