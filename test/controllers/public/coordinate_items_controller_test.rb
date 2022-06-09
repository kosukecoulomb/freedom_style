require "test_helper"

class Public::CoordinateItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_coordinate_items_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_coordinate_items_edit_url
    assert_response :success
  end
end
