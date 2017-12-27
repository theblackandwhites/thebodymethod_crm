require 'test_helper'

class BookableTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookable_type = bookable_types(:one)
  end

  test "should get index" do
    get bookable_types_url
    assert_response :success
  end

  test "should get new" do
    get new_bookable_type_url
    assert_response :success
  end

  test "should create bookable_type" do
    assert_difference('BookableType.count') do
      post bookable_types_url, params: { bookable_type: { description: @bookable_type.description, title: @bookable_type.title } }
    end

    assert_redirected_to bookable_type_url(BookableType.last)
  end

  test "should show bookable_type" do
    get bookable_type_url(@bookable_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookable_type_url(@bookable_type)
    assert_response :success
  end

  test "should update bookable_type" do
    patch bookable_type_url(@bookable_type), params: { bookable_type: { description: @bookable_type.description, title: @bookable_type.title } }
    assert_redirected_to bookable_type_url(@bookable_type)
  end

  test "should destroy bookable_type" do
    assert_difference('BookableType.count', -1) do
      delete bookable_type_url(@bookable_type)
    end

    assert_redirected_to bookable_types_url
  end
end
