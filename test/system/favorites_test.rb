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
    click_on "Favorite"
    assert_text "You have unfavorite"
    page.accept_confirm do
      click_on "Unfavorite"
    end
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

  # test "updating a Favorite" do
  #   visit favorites_url
  #   click_on "Edit", match: :first

  #   fill_in "Restaurant", with: @favorite.restaurant_id
  #   fill_in "User", with: @favorite.user_id
  #   click_on "Update Favorite"

  #   assert_text "Favorite was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Favorite" do
  #   visit favorites_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Favorite was successfully destroyed"
  # end
end
