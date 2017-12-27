require 'test_helper'

class InstructorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @instructor = instructors(:one)
  end

  test "should get index" do
    get instructors_url
    assert_response :success
  end

  test "should get new" do
    get new_instructor_url
    assert_response :success
  end

  test "should create instructor" do
    assert_difference('Instructor.count') do
      post instructors_url, params: { instructor: { address: @instructor.address, bio: @instructor.bio, city: @instructor.city, country: @instructor.country, dob: @instructor.dob, email: @instructor.email, first_name: @instructor.first_name, gender: @instructor.gender, last_name: @instructor.last_name, phone2: @instructor.phone2, phone: @instructor.phone, state: @instructor.state, zipcode: @instructor.zipcode } }
    end

    assert_redirected_to instructor_url(Instructor.last)
  end

  test "should show instructor" do
    get instructor_url(@instructor)
    assert_response :success
  end

  test "should get edit" do
    get edit_instructor_url(@instructor)
    assert_response :success
  end

  test "should update instructor" do
    patch instructor_url(@instructor), params: { instructor: { address: @instructor.address, bio: @instructor.bio, city: @instructor.city, country: @instructor.country, dob: @instructor.dob, email: @instructor.email, first_name: @instructor.first_name, gender: @instructor.gender, last_name: @instructor.last_name, phone2: @instructor.phone2, phone: @instructor.phone, state: @instructor.state, zipcode: @instructor.zipcode } }
    assert_redirected_to instructor_url(@instructor)
  end

  test "should destroy instructor" do
    assert_difference('Instructor.count', -1) do
      delete instructor_url(@instructor)
    end

    assert_redirected_to instructors_url
  end
end
