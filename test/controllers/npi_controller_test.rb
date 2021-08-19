require 'test_helper'

class NpiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get npi_index_url
    assert_response :success
  end

  test "should get show" do
    get npi_show_url
    assert_response :success
  end

end
