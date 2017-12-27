require 'test_helper'

class EnquriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enqury = enquries(:one)
  end

  test "should get index" do
    get enquries_url
    assert_response :success
  end

  test "should get new" do
    get new_enqury_url
    assert_response :success
  end

  test "should create enqury" do
    assert_difference('Enqury.count') do
      post enquries_url, params: { enqury: { email: @enqury.email, full_name: @enqury.full_name, message: @enqury.message, phone: @enqury.phone } }
    end

    assert_redirected_to enqury_url(Enqury.last)
  end

  test "should show enqury" do
    get enqury_url(@enqury)
    assert_response :success
  end

  test "should get edit" do
    get edit_enqury_url(@enqury)
    assert_response :success
  end

  test "should update enqury" do
    patch enqury_url(@enqury), params: { enqury: { email: @enqury.email, full_name: @enqury.full_name, message: @enqury.message, phone: @enqury.phone } }
    assert_redirected_to enqury_url(@enqury)
  end

  test "should destroy enqury" do
    assert_difference('Enqury.count', -1) do
      delete enqury_url(@enqury)
    end

    assert_redirected_to enquries_url
  end
end
