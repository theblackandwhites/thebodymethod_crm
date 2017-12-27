require 'test_helper'

class BookablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookable = bookables(:one)
  end

  test "should get index" do
    get bookables_url
    assert_response :success
  end

  test "should get new" do
    get new_bookable_url
    assert_response :success
  end

  test "should create bookable" do
    assert_difference('Bookable.count') do
      post bookables_url, params: { bookable: { bookable_type_id: @bookable.bookable_type_id, date_start: @bookable.date_start, instructor_id: @bookable.instructor_id, location_id: @bookable.location_id, pay_cash: @bookable.pay_cash, pay_online: @bookable.pay_online, pay_points: @bookable.pay_points, price: @bookable.price, time_finish: @bookable.time_finish, time_finish_unit: @bookable.time_finish_unit, time_start: @bookable.time_start, time_start_unit: @bookable.time_start_unit } }
    end

    assert_redirected_to bookable_url(Bookable.last)
  end

  test "should show bookable" do
    get bookable_url(@bookable)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookable_url(@bookable)
    assert_response :success
  end

  test "should update bookable" do
    patch bookable_url(@bookable), params: { bookable: { bookable_type_id: @bookable.bookable_type_id, date_start: @bookable.date_start, instructor_id: @bookable.instructor_id, location_id: @bookable.location_id, pay_cash: @bookable.pay_cash, pay_online: @bookable.pay_online, pay_points: @bookable.pay_points, price: @bookable.price, time_finish: @bookable.time_finish, time_finish_unit: @bookable.time_finish_unit, time_start: @bookable.time_start, time_start_unit: @bookable.time_start_unit } }
    assert_redirected_to bookable_url(@bookable)
  end

  test "should destroy bookable" do
    assert_difference('Bookable.count', -1) do
      delete bookable_url(@bookable)
    end

    assert_redirected_to bookables_url
  end
end
