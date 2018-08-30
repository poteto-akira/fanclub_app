require 'test_helper'

class PayControllerTest < ActionDispatch::IntegrationTest
  test "should get payment" do
    get pay_payment_url
    assert_response :success
  end

end
