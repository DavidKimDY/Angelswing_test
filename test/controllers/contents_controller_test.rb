require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get contents_create_url
    assert_response :success
  end

  test "should get update" do
    get contents_update_url
    assert_response :success
  end

  test "should get delete" do
    get contents_delete_url
    assert_response :success
  end

  test "should get read" do
    get contents_read_url
    assert_response :success
  end
end
