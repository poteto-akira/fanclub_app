require 'test_helper'

class FcContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fc_contents_index_url
    assert_response :success
  end

end
