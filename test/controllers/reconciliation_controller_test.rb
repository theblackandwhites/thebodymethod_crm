require 'test_helper'

class ReconciliationControllerTest < ActionDispatch::IntegrationTest
  test "should get reconcile" do
    get reconciliation_reconcile_url
    assert_response :success
  end

end
