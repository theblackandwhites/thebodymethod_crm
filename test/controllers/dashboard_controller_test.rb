require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get client_aquisition" do
    get dashboard_client_aquisition_url
    assert_response :success
  end

  test "should get analytics" do
    get dashboard_analytics_url
    assert_response :success
  end

  test "should get schedual" do
    get dashboard_schedual_url
    assert_response :success
  end

end
