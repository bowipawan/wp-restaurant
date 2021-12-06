require "test_helper"

class RestausControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restau = restaus(:one)
  end

  test "should get index" do
    get restaus_url
    assert_response :success
  end

  test "should get new" do
    get new_restau_url
    assert_response :success
  end

  test "should create restau" do
    assert_difference('Restau.count') do
      post restaus_url, params: { restau: { restau_name: @restau.restau_name } }
    end

    assert_redirected_to restau_url(Restau.last)
  end

  test "should show restau" do
    get restau_url(@restau)
    assert_response :success
  end

  test "should get edit" do
    get edit_restau_url(@restau)
    assert_response :success
  end

  test "should update restau" do
    patch restau_url(@restau), params: { restau: { restau_name: @restau.restau_name } }
    assert_redirected_to restau_url(@restau)
  end

  test "should destroy restau" do
    assert_difference('Restau.count', -1) do
      delete restau_url(@restau)
    end

    assert_redirected_to restaus_url
  end
end
